class AddQuantityToItemDetails < ActiveRecord::Migration
  def change
    add_column :item_details, :quantity, :integer
  end
end
