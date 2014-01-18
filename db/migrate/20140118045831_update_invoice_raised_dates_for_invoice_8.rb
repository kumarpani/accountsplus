class UpdateInvoiceRaisedDatesForInvoice8 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 8)).update_attribute :invoice_raised_date, '2013-10-31'
      end
    end
  end
end
