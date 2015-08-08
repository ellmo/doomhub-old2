class AddAccessFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :public_view, :boolean, null: false, default: true
    add_column :projects, :public_join, :boolean, null: false, default: false
  end
end
