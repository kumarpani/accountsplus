class UpdateItemGroupNameToEmptyString < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        ItemDetail.where("item_group_name is NULL").each {
            |i|
          i.update_attribute :item_group_name, ''
        }
      end
    end

  end
end
