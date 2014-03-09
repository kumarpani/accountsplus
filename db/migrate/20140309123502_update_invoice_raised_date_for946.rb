class UpdateInvoiceRaisedDateFor946 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 946)).update_attribute :invoice_raised_date, '2014-03-03'
      end
    end
  end
end
