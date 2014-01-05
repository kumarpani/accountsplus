class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  validates_presence_of :event_date, :event_name
  before_save :update_invoice_details


  serialize :tac

  def start_time
    event_date.to_datetime
  end

  def total_price
    self.service_tax + self.total_item_price
  end

  def total_item_price
    item_details.to_a.sum(&:price)
  end

  def is_a_complete_invoice?
    self.status == INVOICE && self.invoice_type == INVOICE
  end

  def is_open_for_edits?
    self.status != INVOICE || self.invoice_type == PROFORMA
  end

  def is_proforma_invoice_being_raised?
    self.status == INVOICE && self.invoice_type == PROFORMA && self.status_changed?
  end

  def is_invoice_being_raised?
    is_a_complete_invoice? && self.status_changed?
  end


  def update_invoice_details
    if self.is_invoice_being_raised?
      self.service_tax = 0.0
      self.invoice_number = self.invoice_number.nil? ? Quotation.maximum('invoice_number').to_i + 1 : self.invoice_number;
      self.service_tax = ((total_price * 12.36)/100).floor
      self.invoice_raised_date = Date.today
    end

    if is_proforma_invoice_being_raised?
      self.invoice_raised_date = Date.today
    end

  end

  def education_cess
     ((self.service_tax * 2)/100).round(2)
  end

  def higher_education_cess
    ((self.service_tax * 1)/100).round(2)
  end

  def service_tax_at_12_percent
    self.service_tax - self.education_cess - self.higher_education_cess
  end

  def method_missing(method_name, *arguments, &block)

  end

  def clone_with_associations
    @new_quotation = self.dup
    @new_quotation.status = PENDING
    @new_quotation.event_name = '[DUPLICATE] ' + self.event_name
    @new_quotation.invoice_number=nil
    @new_quotation.event_date = DateTime.now.to_date
    @new_quotation.invoice_raised_date = nil
    @new_quotation.notes = '<< This is DUPLICATE quotation. Please update details manually as necessary >> ' + self.notes.to_s

    @new_quotation.save

    self.item_details.each do |i|
      @new_i = i.dup
      @new_i.save
      @new_quotation.item_details << @new_i
    end

    @new_quotation

  end


end
