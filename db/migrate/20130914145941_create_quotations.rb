class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.integer :client_id

      t.timestamps
    end
  end
end
