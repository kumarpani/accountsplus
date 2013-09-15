class AddEventDateToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :event_date, :date
  end
end
