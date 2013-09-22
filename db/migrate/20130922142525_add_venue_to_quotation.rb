class AddVenueToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :venue, :text
  end
end
