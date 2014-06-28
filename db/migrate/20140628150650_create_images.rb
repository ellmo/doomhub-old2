class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :user_id
      t.integer :imageable_id
      t.string :imageable_type
      t.integer  :width
      t.integer  :height
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
