class AddSaccodeToItemdetails < ActiveRecord::Migration
  def change
    add_column :item_details, :saccode, :string
  end
end
