class UpdateInvoiceRaisedDateForInvoice928 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 928)).update_attribute :invoice_raised_date, '2013-12-27'
      end
    end
  end
end
