require "test_helper"

describe Upload do
  let(:user){ users :ellmo }
  let(:project){ projects :dtwid }

  describe 'create' do
    it 'invalid without attached archive file' do
      upload = project.uploads.build user: user
      upload.valid?.must_equal false
      upload.errors.must_include :archive
    end

    it 'invalid without uploadable' do
      upload = Upload.new user: user
      upload.archive = fixture_file_upload('uploads/wadfile.zip')
      upload.valid?.must_equal false
      upload.errors.must_include :uploadable
    end

    it 'invalid without uploader (user)' do
      upload = project.uploads.build
      upload.archive = fixture_file_upload('uploads/wadfile.zip')
      upload.valid?.must_equal false
      upload.errors.must_include :user
    end

    describe 'MIME validation' do
      it 'is valid for zip files' do
        upload = project.uploads.build user: user
        upload.archive = fixture_file_upload('uploads/wadfile.zip')
        upload.valid?.must_equal true
      end

      it 'is valid for rar files' do
        upload = project.uploads.build user: user
        upload.archive = fixture_file_upload('uploads/wadfile.rar')
        upload.valid?.must_equal true
      end

      it 'is valid for 7z files' do
        upload = project.uploads.build user: user
        upload.archive = fixture_file_upload('uploads/wadfile.7z')
        upload.valid?.must_equal true
      end

      it 'is NOT valid for image files' do
        upload = project.uploads.build user: user

        upload.archive = fixture_file_upload('uploads/ellmo.png')
        upload.valid?.must_equal false
        upload.errors.must_include :archive

        upload.archive = fixture_file_upload('uploads/ellmo.jpg')
        upload.valid?.must_equal false
        upload.errors.must_include :archive

        upload.archive = fixture_file_upload('uploads/ellmo.tiff')
        upload.valid?.must_equal false
        upload.errors.must_include :archive
      end
    end
  end

  describe 'file saving' do
    it 'peoperly saves file without a name' do
      upload = project.uploads.build user: user
      upload.archive = fixture_file_upload('uploads/wadfile.zip')
      upload.save
      File.exists?(Rails.root.join("tmp/test-uploads/project/#{project.id}/archives/wadfile-zip-#{upload.id}.zip")).must_equal true
    end
  end
end