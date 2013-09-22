class CreatePrintQuotations < ActiveRecord::Migration
  def change
    create_table :print_quotations do |t|

      t.timestamps
    end
  end
end
