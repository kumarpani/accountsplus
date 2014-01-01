class RemoveInvalidInvoicesFromQuotations < ActiveRecord::Migration
  def change
    Quotation.destroy_all :invoice_number => 16
    Quotation.destroy_all :invoice_number => 26
    Quotation.destroy_all :invoice_number => 27
    Quotation.destroy_all :invoice_number => 28
    Quotation.destroy_all :invoice_number => 30
  end
end
