class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  validates_presence_of :event_date
  before_save :update_service_tax


  serialize :tac

  def start_time
    event_date.to_datetime
  end

  def total_price
    self.service_tax + item_details.to_a.sum(&:price)
  end

  def update_service_tax
    self.service_tax = 0.0
    if status == 'Invoice' && invoice_type == 'Invoice'
      self.service_tax = ((total_price * 12.36)/100).floor
    end
  end

  def is_service_tax_row_needed?
    self.status == 'Invoice' && self.invoice_type == 'Invoice'
  end

  def is_open_for_edits?
    self.status != 'Invoice' || self.invoice_type == 'Proforma Invoice'
  end

end
