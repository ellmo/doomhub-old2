class Image < ActiveRecord::Base
  include MimeChecker
  include Image::Paperclippable

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :imageable, polymorphic: true

#==============
#= VALIDATIONS
#============

  validates :user, presence: true

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
