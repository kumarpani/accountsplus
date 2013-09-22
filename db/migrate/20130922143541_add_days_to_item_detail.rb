class AddDaysToItemDetail < ActiveRecord::Migration
  def change
    add_column :item_details, :days, :integer
  end
end
