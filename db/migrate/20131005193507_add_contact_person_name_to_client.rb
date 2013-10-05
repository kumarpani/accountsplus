class AddContactPersonNameToClient < ActiveRecord::Migration
  def change
    add_column :clients, :contact_person_name, :string
  end
end
