require "test_helper"

describe Upload do
  fixtures = [
    {klass: :projects, name: :dtwid},
    {klass: :maps, name: :engineering_bay},
  ]

  let(:user){ users :ellmo }
  fixtures.each do |fixture|
    let(:uploadable){ send(fixture[:klass], fixture[:name]) }

    describe 'create' do
      it 'invalid without attached archive file' do
        upload = uploadable.uploads.build user: user
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
        upload = uploadable.uploads.build
        upload.archive = fixture_file_upload('uploads/wadfile.zip')
        upload.valid?.must_equal false
        upload.errors.must_include :user
      end

      describe 'MIME validation' do
        it 'is valid for zip files' do
          upload = uploadable.uploads.build user: user
          upload.archive = fixture_file_upload('uploads/wadfile.zip')
          upload.valid?.must_equal true
        end

        it 'is valid for rar files' do
          upload = uploadable.uploads.build user: user
          upload.archive = fixture_file_upload('uploads/wadfile.rar')
          upload.valid?.must_equal true
        end

        it 'is valid for 7z files' do
          upload = uploadable.uploads.build user: user
          upload.archive = fixture_file_upload('uploads/wadfile.7z')
          upload.valid?.must_equal true
        end

        it 'is NOT valid for image files' do
          upload = uploadable.uploads.build user: user

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
        upload = uploadable.uploads.build user: user
        upload.archive = fixture_file_upload('uploads/wadfile.zip')
        upload.save
        File.exists?(Rails.root.join("tmp/test-uploads/#{uploadable.class.to_s.downcase}/#{uploadable.id}/archives/wadfile-zip-#{upload.id}.zip")).must_equal true
      end
    end
  end
end