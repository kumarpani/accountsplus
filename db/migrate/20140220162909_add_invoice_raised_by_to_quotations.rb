class AddInvoiceRaisedByToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :invoice_raised_by, :string
  end
end
