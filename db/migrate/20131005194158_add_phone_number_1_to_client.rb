class AddPhoneNumber1ToClient < ActiveRecord::Migration
  def change
    add_column :clients, :phone_number_1, :string
  end
end
