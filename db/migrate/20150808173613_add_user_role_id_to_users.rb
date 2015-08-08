class AddUserRoleIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_role, index: true
  end
end
