class AddCustomTacToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :custom_tac, :text
 end
end
