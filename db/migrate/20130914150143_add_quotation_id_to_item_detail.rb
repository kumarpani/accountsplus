class AddQuotationIdToItemDetail < ActiveRecord::Migration
  def change
    add_column :item_details, :quotation_id, :integer
  end
end
