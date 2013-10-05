class AddItemDetailIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :item_detail_id, :integer
  end
end
