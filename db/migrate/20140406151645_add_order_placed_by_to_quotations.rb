class AddOrderPlacedByToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :order_placed_by, :string
  end
end
