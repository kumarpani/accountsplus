class AddNotesToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :notes, :string
  end
end
