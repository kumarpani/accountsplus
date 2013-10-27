class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  validates_presence_of :event_date, :event_name
  before_save :populate_invoice_details


  serialize :tac

  def start_time
    event_date.to_datetime
  end

  def total_price
    self.service_tax + item_details.to_a.sum(&:price)
  end

  def populate_invoice_details
    self.service_tax = 0.0
    if status == INVOICE && invoice_type == INVOICE
      self.invoice_number = self.invoice_number.nil? ? Quotation.maximum('invoice_number').to_i + 1 : self.invoice_number;
      self.service_tax = ((total_price * 12.36)/100).floor
      self.invoice_raised_date = Date.today
    end
  end

  def is_a_complete_invoice?
    self.status == INVOICE && self.invoice_type == INVOICE
  end

  def is_open_for_edits?
    self.status != INVOICE || self.invoice_type == PROFORMA
  end

end
