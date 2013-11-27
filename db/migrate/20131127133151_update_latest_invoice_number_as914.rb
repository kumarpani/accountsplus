class UpdateLatestInvoiceNumberAs914 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.maximum('invoice_number')).update_attribute :invoice_number, 914
      end
    end
  end
end
