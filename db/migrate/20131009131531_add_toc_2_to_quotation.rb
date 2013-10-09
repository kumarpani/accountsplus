class AddToc2ToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :toc, :text
  end
end
