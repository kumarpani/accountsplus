class AddTac2ToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :tac, :text
  end
end
