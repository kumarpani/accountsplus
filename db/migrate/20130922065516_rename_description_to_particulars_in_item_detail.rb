class RenameDescriptionToParticularsInItemDetail < ActiveRecord::Migration
  def change
    rename_column :item_details, :description, :particulars
  end
end
