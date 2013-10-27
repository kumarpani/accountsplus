class AddVendorIdToItemDetail < ActiveRecord::Migration
  def change
    add_column :item_details, :vendor_id, :integer
  end
end
