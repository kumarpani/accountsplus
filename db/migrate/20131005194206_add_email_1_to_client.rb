class AddEmail1ToClient < ActiveRecord::Migration
  def change
    add_column :clients, :email_1, :string
  end
end
