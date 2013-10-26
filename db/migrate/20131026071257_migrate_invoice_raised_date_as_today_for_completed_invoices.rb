class MigrateInvoiceRaisedDateAsTodayForCompletedInvoices < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Quotation.where("status='Invoice' AND invoice_type='Invoice'").each {
            |q|
          q.update_attribute :invoice_raised_date, Date.today
        }
      end
    end
  end
end
