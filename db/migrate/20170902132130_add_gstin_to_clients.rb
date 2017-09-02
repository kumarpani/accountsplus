class AddGstinToClients < ActiveRecord::Migration
  def change
    add_column :clients, :gstin, :string
  end
end
