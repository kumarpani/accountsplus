class AddPaymentAddedByToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payment_added_by, :string
    add_column :payments, :payment_last_modified_by, :string
  end
end
