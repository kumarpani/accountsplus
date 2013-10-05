class AddDaysToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :days, :integer
  end
end
