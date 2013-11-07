class AddUnitPriceToItemDetails < ActiveRecord::Migration
  def change
    add_column :item_details, :unit_price, :decimal
  end
end
