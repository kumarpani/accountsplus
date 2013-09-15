class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :client_id
      t.text :description
      t.string :mode
      t.date :paid_on
      t.decimal :amount

      t.timestamps
    end
  end
end
