class UpdateInvoiceNumbers2 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do

        Quotation.find(Quotation.where(:invoice_number => 22)).update_attribute :invoice_number, 903
        Quotation.find(Quotation.where(:invoice_number => 903)).update_attribute :invoice_raised_date, '2013-11-20'

        Quotation.find(Quotation.where(:invoice_number => 25)).update_attribute :invoice_number, 904
        Quotation.find(Quotation.where(:invoice_number => 904)).update_attribute :invoice_raised_date, '2013-11-21'

        Quotation.find(Quotation.where(:invoice_number => 24)).update_attribute :invoice_number, 905
        Quotation.find(Quotation.where(:invoice_number => 905)).update_attribute :invoice_raised_date, '2013-11-23'

        Quotation.find(Quotation.where(:invoice_number => 23)).update_attribute :invoice_number, 906
        Quotation.find(Quotation.where(:invoice_number => 906)).update_attribute :invoice_raised_date, '2013-11-23'

        Quotation.find(Quotation.where(:invoice_number => 29)).update_attribute :invoice_number, 907
        Quotation.find(Quotation.where(:invoice_number => 907)).update_attribute :invoice_raised_date, '2013-11-23'

        Quotation.find(Quotation.where(:invoice_number => 31)).update_attribute :invoice_number, 912
        Quotation.find(Quotation.where(:invoice_number => 912)).update_attribute :invoice_raised_date, '2013-11-24'

        Quotation.find(Quotation.where(:invoice_number => 32)).update_attribute :invoice_number, 913
        Quotation.find(Quotation.where(:invoice_number => 913)).update_attribute :invoice_raised_date, '2013-11-25'

      end
    end
  end
end
