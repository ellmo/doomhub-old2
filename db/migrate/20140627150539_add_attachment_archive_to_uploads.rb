class AddAttachmentArchiveToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :archive
    end
  end

  def self.down
    drop_attached_file :uploads, :archive
  end
end
