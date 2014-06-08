class AddPaidToToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :paid_to, :string
  end
end
