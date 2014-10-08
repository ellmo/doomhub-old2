class Upload < ActiveRecord::Base
  include MimeChecker

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
  do_not_validate_attachment_file_type :archive #doing this manually
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

  Paperclip.interpolates :uploadable_name do |attachment, style|
    (attachment.instance.name || attachment.instance.archive_file_name).parameterize
  end

  def check_attachment
    check_attachment_mime
    check_attachment_size
  end

  def check_attachment_mime
    if check_mimes(archive_file_name, ALLOWED_MIMES).empty?
      errors[:archive] << "File must be a valid zip / rar / 7z achive"
    end
  end

  def check_attachment_size
    if archive.size > 1.megabyte
      errors[:archive] << "File must not be over 1 MB"
    end
  end

  private :check_attachment, :check_attachment_mime, :check_attachment_size

#============
#= CALLBACKS
#==========

  before_save :generate_name, unless: ->(u) {u.name.present?}

  def generate_name
    self.name = archive_file_name.parameterize
  end

end
