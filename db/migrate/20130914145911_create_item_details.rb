class CreateItemDetails < ActiveRecord::Migration
  def change
    create_table :item_details do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.timestamps
    end
  end
end
