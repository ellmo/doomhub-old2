class Image < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :imageable, polymorphic: true

#============
#= PAPERCLIP
#==========

  has_attached_file :image,
                    keep_old_files: true,
                    url: ':path',
                    path: ENV['PAPERCLIP_IMAGE_IMAGE_PATH']
  do_not_validate_attachment_file_type :image
  validates_attachment_presence :image

#==============
#= VALIDATIONS
#============

  validates :user, presence: true
  validates :imageable, presence: true
  validate :check_attachment, if: ->(u) { u.image_file_name.present? }

  ALLOWED_MIMES = ["image/jpeg", "image/png", "image/tiff"]

  Paperclip.interpolates :imageable_type do |attachment, style|
    attachment.instance.imageable_type.downcase
  end

  Paperclip.interpolates :imageable_id do |attachment, style|
    attachment.instance.imageable_id
  end

  Paperclip.interpolates :imageable_name do |attachment, style|
    (attachment.instance.name || attachment.instance.image_file_name).parameterize
  end

  def check_attachment
    if (MIME::Types.type_for(image_file_name).map(&:to_s) & ALLOWED_MIMES).empty?
      errors[:image] << "File must be a valid JPG / PNG / TIFF image"
    end
    if image.size > 1.megabyte
      errors[:image] << "File must not be over 1 MB"
    end
  end

#============
#= CALLBACKS
#==========
  before_create :save_geometry
  before_save :generate_name, unless: ->(img) {img.name.present?}

  def save_geometry
    geo = get_geometry
    if geo
      self.width = geo.width.to_i
      self.height = geo.height.to_i
    end
  end

  def get_geometry(style = :original)
    begin
      Paperclip::Geometry.from_file(image.queued_for_write[style])
    rescue
      nil
    end
  end

  def generate_name
    self.name = image_file_name.parameterize
  end

end
