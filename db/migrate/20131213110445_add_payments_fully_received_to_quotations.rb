class AddPaymentsFullyReceivedToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :payment_received_in_full, :boolean
  end
end
