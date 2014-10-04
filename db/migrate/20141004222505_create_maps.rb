class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :author_id
      t.integer :project_id
      t.string :lump
      t.string :name
      t.string :url_name
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
