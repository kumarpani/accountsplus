class UpdateInvoiceNumbers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 12)).update_attribute :invoice_number, 887
        Quotation.find(Quotation.where(:invoice_number => 887)).update_attribute :invoice_raised_date, '2013-10-06'

        Quotation.find(Quotation.where(:invoice_number => 1)).update_attribute :invoice_number, 888
        Quotation.find(Quotation.where(:invoice_number => 888)).update_attribute :invoice_raised_date, '2013-10-12'

        Quotation.find(Quotation.where(:invoice_number => 13)).update_attribute :invoice_number, 890
        Quotation.find(Quotation.where(:invoice_number => 890)).update_attribute :invoice_raised_date, '2013-10-18'

        Quotation.find(Quotation.where(:invoice_number => 9)).update_attribute :invoice_number, 891
        Quotation.find(Quotation.where(:invoice_number => 891)).update_attribute :invoice_raised_date, '2013-10-31'

        Quotation.find(Quotation.where(:invoice_number => 7)).update_attribute :invoice_number, 892
        Quotation.find(Quotation.where(:invoice_number => 892)).update_attribute :invoice_raised_date, '2013-10-31'

        Quotation.find(Quotation.where(:invoice_number => 8)).update_attribute :invoice_number, 893
        Quotation.find(Quotation.where(:invoice_number => 893)).update_attribute :invoice_raised_date, '2013-10-31'

        Quotation.find(Quotation.where(:invoice_number => 19)).update_attribute :invoice_number, 894
        Quotation.find(Quotation.where(:invoice_number => 894)).update_attribute :invoice_raised_date, '2013-10-31'

        Quotation.find(Quotation.where(:invoice_number => 15)).update_attribute :invoice_number, 895
        Quotation.find(Quotation.where(:invoice_number => 895)).update_attribute :invoice_raised_date, '2013-11-06'

        Quotation.find(Quotation.where(:invoice_number => 14)).update_attribute :invoice_number, 897
        Quotation.find(Quotation.where(:invoice_number => 897)).update_attribute :invoice_raised_date, '2013-11-07'

        Quotation.find(Quotation.where(:invoice_number => 18)).update_attribute :invoice_number, 898
        Quotation.find(Quotation.where(:invoice_number => 898)).update_attribute :invoice_raised_date, '2013-11-07'

        Quotation.find(Quotation.where(:invoice_number => 17)).update_attribute :invoice_number, 899
        Quotation.find(Quotation.where(:invoice_number => 899)).update_attribute :invoice_raised_date, '2013-11-07'

        Quotation.find(Quotation.where(:invoice_number => 20)).update_attribute :invoice_number, 900
        Quotation.find(Quotation.where(:invoice_number => 900)).update_attribute :invoice_raised_date, '2013-11-11'

        Quotation.find(Quotation.where(:invoice_number => 21)).update_attribute :invoice_number, 901
        Quotation.find(Quotation.where(:invoice_number => 901)).update_attribute :invoice_raised_date, '2013-11-13'

      end
    end
  end
end
