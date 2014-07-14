class AddReferenceNumberToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :reference_number, :string
  end
end
