class MigrateExistingPaymentRecordsWithItemDetailId < ActiveRecord::Migration
  def change
    reversible do |dir|
      ItemDetail.reset_column_information
      dir.up do
        payments = Payment.where('item_detail_id IS NOT NULL')
        payments.each { |p|
          item_detail = ItemDetail.find(p.item_detail_id)
          item_detail.update(vendor_id: p.client_id, vendor_price: p.amount)
          p.destroy
        }
        Quotation.where(status: 'Invoice').each { |q| q.item_details.select { |i| !i.vendor_id.nil? }.group_by { |i| i.vendor_id }.each_pair { |vendor_id, items|
          vendor_payment_record = Payment.find_or_create_by(quotation_id: q.id, client_id: vendor_id)
          sum = items.reduce(0) { |sum, item_detail| sum + item_detail.vendor_price }
          vendor_payment_record.update(amount: sum, payment_type: 'Debit', paid_on: DateTime.now)
        }
        }
      end
    end
  end
end
