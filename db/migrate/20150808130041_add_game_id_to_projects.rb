class AddGameIdToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :game, index: true
  end
end
