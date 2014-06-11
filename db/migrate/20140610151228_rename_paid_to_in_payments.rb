class RenamePaidToInPayments < ActiveRecord::Migration
  def change
    rename_column :payments, :paid_to, :received_by
  end
end
