class RemoveNameFromItemDetail < ActiveRecord::Migration
  def change
    remove_column :item_details, :name, :string
  end
end
