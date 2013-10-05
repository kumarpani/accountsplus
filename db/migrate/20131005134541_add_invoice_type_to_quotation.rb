class AddInvoiceTypeToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :invoice_type, :string
  end
end
