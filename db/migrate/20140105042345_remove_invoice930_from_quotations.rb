class RemoveInvoice930FromQuotations < ActiveRecord::Migration
  def change
    Quotation.destroy_all :invoice_number => 930
  end
end
