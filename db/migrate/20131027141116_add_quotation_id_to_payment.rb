class AddQuotationIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :quotation_id, :integer
  end
end
