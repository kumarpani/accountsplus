class RemoveVendorDetailsFromItemDetails < ActiveRecord::Migration
  def change
    remove_column :item_details, :vendor_id, :integer
    remove_column :item_details, :vendor_quantity, :integer
    remove_column :item_details, :vendor_price, :decimal
  end
end
