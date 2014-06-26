class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string  :name
      t.string  :url_name, :null => false
      t.string  :slug, :null => false
      t.text    :description

      t.timestamps
    end
  end
end
