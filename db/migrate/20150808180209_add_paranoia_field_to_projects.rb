class AddParanoiaFieldToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :deleted_at, :datetime
  end
end
