class RenameNameToCompanyNameInClient < ActiveRecord::Migration
  def change
    rename_column :clients, :name, :company_name
  end
end
