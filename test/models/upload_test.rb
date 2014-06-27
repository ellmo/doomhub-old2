require "test_helper"

class UploadTest < ActiveSupport::TestCase

  def upload
    @upload ||= Upload.new
  end

  def test_valid
    assert upload.valid?
  end

end
