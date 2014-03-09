class UpdateEventDateFor946 < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.find(Quotation.where(:invoice_number => 946)).update_attribute :event_date, '2014-02-24'
      end
    end
  end
end
