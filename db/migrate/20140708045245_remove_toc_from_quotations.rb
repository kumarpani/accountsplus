class RemoveTocFromQuotations < ActiveRecord::Migration
  def change
    remove_column :quotations, :toc, :text
  end
end
