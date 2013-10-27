class RenameNameColumnToEventName < ActiveRecord::Migration
  def change
    rename_column :quotations, :name, :event_name
  end
end
