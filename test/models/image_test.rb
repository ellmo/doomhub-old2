require "test_helper"

describe Image do
  let(:user){ users :ellmo }
  let(:project){ projects :dtwid }

  describe 'create' do
    it 'invalid without attached image file' do
      image = project.images.build user: user
      image.valid?.must_equal false
      image.errors.must_include :image
    end

    it 'invalid without imageable' do
      image = Image.new user: user
      image.image = fixture_file_upload('uploads/ellmo.png')
      image.valid?.must_equal false
      image.errors.must_include :imageable
    end

    it 'invalid without uploader (user)' do
      image = project.images.build
      image.image = fixture_file_upload('uploads/ellmo.png')
      image.valid?.must_equal false
      image.errors.must_include :user
    end
  end
end