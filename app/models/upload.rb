class Upload < ActiveRecord::Base

#========
#= ASSOC
#======

  belongs_to :user
  belongs_to :uploadable, polymorphic: true

#============
#= PAPERCLIP
#==========

  has_attached_file :archive,
                    keep_old_files: true,
                    url: ':path',
                    path: ENV['PAPERCLIP_UPLOAD_ARCHIVE_PATH']
  do_not_validate_attachment_file_type :archive
  validates_attachment_presence :archive

#==============
#= VALIDATIONS
#============

  validates :user, presence: true
  validates :uploadable, presence: true
  validate :check_attachment, if: ->(u) { u.archive_file_name.present? }

  ALLOWED_MIMES = ["application/zip", "application/x-7z-compressed", "application/x-rar-compressed"]

  Paperclip.interpolates :uploadable_type do |attachment, style|
    attachment.instance.uploadable_type.downcase
  end

  Paperclip.interpolates :uploadable_id do |attachment, style|
    attachment.instance.uploadable_id
  end

  Paperclip.interpolates :name do |attachment, style|
    (attachment.instance.name || attachment.instance.archive_file_name).parameterize
  end

  def check_attachment
    if (MIME::Types.type_for(archive_file_name).map(&:to_s) & ALLOWED_MIMES).empty?
      errors[:archive] << "File must be a valid zip / rar / 7z achive"
    end
    if archive.size > 1.megabyte
      errors[:archive] << "File must not be over 1 MB"
    end
  end

#============
#= CALLBACKS
#==========

  before_save :generate_name, unless: ->(u) {u.name.present?}

  def generate_name
    self.name = archive_file_name.parameterize
  end

end
