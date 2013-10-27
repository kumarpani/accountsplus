class AddVendorQuantityToItemDetail < ActiveRecord::Migration
  def change
    add_column :item_details, :vendor_quantity, :integer
  end
end
