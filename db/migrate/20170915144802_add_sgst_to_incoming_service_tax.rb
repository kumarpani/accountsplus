class AddSgstToIncomingServiceTax < ActiveRecord::Migration
  def change
    add_column :incoming_service_taxes, :sgst, :decimal
  end
end
