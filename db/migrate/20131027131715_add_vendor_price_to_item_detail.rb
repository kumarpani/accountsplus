class AddVendorPriceToItemDetail < ActiveRecord::Migration
  def change
    add_column :item_details, :vendor_price, :decimal
  end
end
