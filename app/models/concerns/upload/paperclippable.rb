class Upload
  module Paperclippable
    extend ActiveSupport::Concern

    ALLOWED_MIMES = ["application/zip", "application/x-7z-compressed", "application/x-rar-compressed"]

    included do
      has_attached_file :archive,
                    keep_old_files: true,
                    url: ':path',
                    path: ENV['PAPERCLIP_UPLOAD_ARCHIVE_PATH']
      do_not_validate_attachment_file_type :archive #doing this manually
      validates_attachment_presence :archive

      validates :uploadable, presence: true
      validate :check_attachment_mime, if: ->(u) { u.archive_file_name.present? }
      validate :check_attachment_size, if: ->(u) { u.archive_file_name.present? }
    end

    module ClassMethods
      Paperclip.interpolates :uploadable_type do |attachment, style|
        attachment.instance.uploadable_type.downcase
      end

      Paperclip.interpolates :uploadable_id do |attachment, style|
        attachment.instance.uploadable_id
      end

      Paperclip.interpolates :uploadable_name do |attachment, style|
        (attachment.instance.name || attachment.instance.archive_file_name).parameterize
      end
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

    private :check_attachment_mime, :check_attachment_size
  end
end