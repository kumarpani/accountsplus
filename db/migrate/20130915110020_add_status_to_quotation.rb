class AddStatusToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :status, :string
  end
end
