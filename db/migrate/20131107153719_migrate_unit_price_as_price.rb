class MigrateUnitPriceAsPrice < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        ItemDetail.all.each {
            |i|
          i.update_attribute :unit_price, i.price
          i.update_attribute :quantity, 1
          i.update_attribute :days, 1
        }
      end
    end

  end
end
