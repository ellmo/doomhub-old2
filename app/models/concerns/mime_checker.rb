module MimeChecker
  extend ActiveSupport::Concern

  def check_mimes(file_name, allowed_mimes)
    return MIME::Types.type_for(file_name).map(&:to_s) & allowed_mimes
  end
end