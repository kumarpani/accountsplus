class RemoveItemDetailIdFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :item_detail_id, :integer
  end
end
