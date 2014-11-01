module MimeChecker
  extend ActiveSupport::Concern

  included do
    validate :check_attachment, if: ->(u) { u.public_send("#{self.class.attachment}_file_name").present? }
  end

  module ClassMethods
    def attachment
      attachment_definitions.keys.first
    end
  end

  def check_attachment
    check_attachment_mime
    check_attachment_size
  end

  def check_mimes(file_name, allowed_mimes)
    return MIME::Types.type_for(file_name).map(&:to_s) & allowed_mimes
  end

  def check_attachment_mime
    # binding.pry
    if check_mimes(public_send("#{self.class.attachment}_file_name"), self.class::ALLOWED_MIMES).empty?
      errors[self.class.attachment.to_sym] << "File must be a valid #{self.class::ALLOWED_MIMES.join(' / ')}."
    end
  end

  def check_attachment_size
    if public_send("#{self.class.attachment}").size > 1.megabyte
      errors[self.class.attachment.to_sym] << "File must not be over 1 MB"
    end
  end

  private :check_attachment_mime, :check_attachment_size
end