class UpdateInvoiceNumberFor11 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 11)).update_attribute :invoice_number, 885
        Quotation.find(Quotation.where(:invoice_number => 885)).update_attribute :invoice_raised_date, '2013-10-02'
      end
    end
  end
end
