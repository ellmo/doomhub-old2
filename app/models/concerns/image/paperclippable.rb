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
  end
end