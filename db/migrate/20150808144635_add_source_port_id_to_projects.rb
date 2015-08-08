class AddSourcePortIdToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :source_port, index: true
  end
end
