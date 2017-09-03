class AddEventEndDateToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :event_end_date, :date
  end
end
