class UpdateFewMoreInvoiceRaisedDates < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 916)).update_attribute :invoice_raised_date, '2013-11-28'
        Quotation.find(Quotation.where(:invoice_number => 917)).update_attribute :invoice_raised_date, '2013-11-29'
        Quotation.find(Quotation.where(:invoice_number => 918)).update_attribute :invoice_raised_date, '2013-11-30'
        Quotation.find(Quotation.where(:invoice_number => 919)).update_attribute :invoice_raised_date, '2013-12-02'
        Quotation.find(Quotation.where(:invoice_number => 920)).update_attribute :invoice_raised_date, '2013-12-09'
        Quotation.find(Quotation.where(:invoice_number => 921)).update_attribute :invoice_raised_date, '2013-12-11'
      end
    end
  end
end
