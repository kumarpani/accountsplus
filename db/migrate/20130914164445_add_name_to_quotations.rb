class AddNameToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :name, :string
  end
end
