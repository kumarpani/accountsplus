class UpdateInvoiceRaisedDates < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 8)).update_attribute :invoice_raised_date, '2013-10-25'
        Quotation.find(Quotation.where(:invoice_number => 13)).update_attribute :invoice_raised_date, '2013-11-06'
        Quotation.find(Quotation.where(:invoice_number => 14)).update_attribute :invoice_raised_date, '2013-11-06'
        Quotation.find(Quotation.where(:invoice_number => 19)).update_attribute :invoice_raised_date, '2013-11-08'
        Quotation.find(Quotation.where(:invoice_number => 20)).update_attribute :invoice_raised_date, '2013-11-19'
        Quotation.find(Quotation.where(:invoice_number => 21)).update_attribute :invoice_raised_date, '2013-11-20'
        Quotation.find(Quotation.where(:invoice_number => 22)).update_attribute :invoice_raised_date, '2013-11-22'
        Quotation.find(Quotation.where(:invoice_number => 29)).update_attribute :invoice_raised_date, '2013-11-25'
        Quotation.find(Quotation.where(:invoice_number => 31)).update_attribute :invoice_raised_date, '2013-11-25'
        Quotation.find(Quotation.where(:invoice_number => 916)).update_attribute :invoice_raised_date, '2013-12-02'
        Quotation.find(Quotation.where(:invoice_number => 917)).update_attribute :invoice_raised_date, '2013-12-03'
        Quotation.find(Quotation.where(:invoice_number => 918)).update_attribute :invoice_raised_date, '2013-12-05'
        Quotation.find(Quotation.where(:invoice_number => 920)).update_attribute :invoice_raised_date, '2013-12-16'
      end
    end
  end
end
