class CreateIncomingServiceTaxes < ActiveRecord::Migration
  def change
    create_table :incoming_service_taxes do |t|
      t.integer :invoice_number
      t.date :invoice_date
      t.string :description
      t.decimal :event_total
      t.decimal :service_tax

      t.timestamps
    end
  end
end
