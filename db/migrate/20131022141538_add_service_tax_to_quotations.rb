class AddServiceTaxToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :service_tax, :decimal, :default => 0
  end
end
