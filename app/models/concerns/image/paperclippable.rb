class Image
  module Paperclippable
    extend ActiveSupport::Concern

    ALLOWED_MIMES = ["image/jpeg", "image/png", "image/tiff"]

    included do
      has_attached_file :image,
                    keep_old_files: true,
                    url: ':path',
                    path: ENV['PAPERCLIP_IMAGE_IMAGE_PATH']
      do_not_validate_attachment_file_type :image #doing this manually
      validates_attachment_presence :image

      validates :imageable, presence: true
      validate :check_attachment_mime, if: ->(u) { u.image_file_name.present? }
      validate :check_attachment_size, if: ->(u) { u.image_file_name.present? }
    end

    module ClassMethods
      Paperclip.interpolates :imageable_type do |attachment, style|
        attachment.instance.imageable_type.downcase
      end

      Paperclip.interpolates :imageable_id do |attachment, style|
        attachment.instance.imageable_id
      end

      Paperclip.interpolates :imageable_name do |attachment, style|
        (attachment.instance.name || attachment.instance.image_file_name).parameterize
      end
    end

    def check_attachment_mime
      if check_mimes(image_file_name, ALLOWED_MIMES).empty?
        errors[:image] << "File must be a valid png / jpg / tiff image."
      end
    end

    def check_attachment_size
      if image.size > 1.megabyte
        errors[:image] << "File must not be over 1 MB"
      end
    end

    private :check_attachment_mime, :check_attachment_size
  end
end