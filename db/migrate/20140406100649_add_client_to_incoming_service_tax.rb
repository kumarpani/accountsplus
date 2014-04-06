class AddClientToIncomingServiceTax < ActiveRecord::Migration
  def change
    add_column :incoming_service_taxes, :client_id, :string
  end
end
