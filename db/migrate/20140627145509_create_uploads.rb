class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name
      t.integer :user_id
      t.integer :uploadable_id
      t.string :uploadable_type
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
