class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  validates_presence_of :event_date, :event_name
  before_save :populate_invoice_details
  after_save :update_vendor_payments


  serialize :tac

  def start_time
    event_date.to_datetime
  end

  def total_price
    self.service_tax + item_details.to_a.sum(&:price)
  end

  def is_a_complete_invoice?
    self.status == INVOICE && self.invoice_type == INVOICE
  end

  def is_open_for_edits?
    self.status != INVOICE || self.invoice_type == PROFORMA
  end

  def update_vendor_payments
    if self.status == INVOICE && self.status_changed?
      self.item_details.select {|i| !i.vendor_id.nil? }.group_by {|i| i.vendor_id}.each_pair {|vendor_id, items|
        vendor_payment_record = Payment.find_or_create_by(quotation_id: self.id, client_id: vendor_id)
        sum = items.reduce(0) { |sum, item_detail| sum + item_detail.vendor_price }
        vendor_payment_record.update(amount: sum, payment_type: 'Debit', paid_on: DateTime.now, description: "#{self.event_date} #{self.event_name}")
      }
    end
  end

  def populate_invoice_details
    self.service_tax = 0.0
    if status == INVOICE && invoice_type == INVOICE
      self.invoice_number = self.invoice_number.nil? ? Quotation.maximum('invoice_number').to_i + 1 : self.invoice_number;
      self.service_tax = ((total_price * 12.36)/100).floor
      self.invoice_raised_date = Date.today
    end
  end

  def method_missing(method_name, *arguments, &block)

  end
end
