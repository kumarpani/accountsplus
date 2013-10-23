class AddInvoiceNumberToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :invoice_number, :integer
  end
end
