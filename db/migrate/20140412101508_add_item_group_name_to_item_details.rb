class AddItemGroupNameToItemDetails < ActiveRecord::Migration
  def change
    add_column :item_details, :item_group_name, :string
  end
end
