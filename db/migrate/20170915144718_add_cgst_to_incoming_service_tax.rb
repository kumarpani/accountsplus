class AddCgstToIncomingServiceTax < ActiveRecord::Migration
  def change
    add_column :incoming_service_taxes, :cgst, :decimal
  end
end
