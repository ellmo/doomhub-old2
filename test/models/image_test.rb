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

    describe 'MIME validation' do
      it 'is valid for png files' do
        image = project.images.build user: user
        image.image = fixture_file_upload('uploads/ellmo.png')
        image.valid?.must_equal true
      end

      it 'is valid for jpg files' do
        image = project.images.build user: user
        image.image = fixture_file_upload('uploads/ellmo.jpg')
        image.valid?.must_equal true
      end

      it 'is valid for tiff files' do
        image = project.images.build user: user
        image.image = fixture_file_upload('uploads/ellmo.tiff')
        image.valid?.must_equal true
      end

      it 'is NOT valid for archive files' do
        image = project.images.build user: user

        image.image = fixture_file_upload('uploads/wadfile.zip')
        image.valid?.must_equal false
        image.errors.must_include :image

        # image.image = fixture_file_upload('uploads/wadfile.rar')
        # image.valid?.must_equal false
        # image.errors.must_include :image

        image.image = fixture_file_upload('uploads/wadfile.7z')
        image.valid?.must_equal false
        image.errors.must_include :image
      end
    end
  end

  describe 'file saving' do
    it 'peoperly saves file without a name' do
      image = project.images.build user: user
      image.image = fixture_file_upload('uploads/ellmo.png')
      image.save
      File.exists?(Rails.root.join("tmp/test-uploads/project/#{project.id}/images/ellmo-png-#{image.id}.png")).must_equal true
    end
  end
end