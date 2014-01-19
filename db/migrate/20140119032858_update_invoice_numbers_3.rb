class UpdateInvoiceNumbers3 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do

        Quotation.find(Quotation.where(:invoice_number => 914)).update_attribute :invoice_number, nil
        Quotation.find(Quotation.where(:invoice_number => 33)).update_attribute :invoice_number, 914
        Quotation.find(Quotation.where(:invoice_number => 914)).update_attribute :invoice_raised_date, '2013-11-25'

      end
    end
  end
end
