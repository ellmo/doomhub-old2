class AddItemAccessRefToProjets < ActiveRecord::Migration
  def change
    add_reference :projects, :item_access, index: true
  end
end
