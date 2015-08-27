class ChangeDaysToDecimalInItemDetail < ActiveRecord::Migration
  def change
    change_column :item_details, :days, :decimal, :precision => 5, :scale => 2
 end
end
