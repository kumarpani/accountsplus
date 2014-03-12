class RemoveQuotation286 < ActiveRecord::Migration
  def change
    Quotation.destroy_all :id => 286

  end
end
