class MigrateExistingInvoiceToInvoiceWithNumbers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.where("status='Invoice' AND invoice_type='Invoice'").sort_by { |q| q.created_at }.each_with_index {
            |q, i|
          q.update_attribute :invoice_number, i+1
        }
      end
    end
  end
end
