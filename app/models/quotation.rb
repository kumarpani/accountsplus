class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  validates_presence_of :event_date, :event_name, :client_id, :invoice_type, :status
  before_save :update_invoice_details


  serialize :tac

  def start_time
    event_date.to_datetime
  end

  def total_item_price
    item_details.to_a.sum(&:price)
  end

  def total_price
    total = self.service_tax + self.total_item_price
    floor_value = total.floor
    fraction = total - floor_value
    fraction >= 0.20 ? (floor_value+1) : floor_value;
  end

  def service_tax_at_12_percent
    if self.invoice_type == INVOICE_TAX
      ApplicationController.helpers.number_with_precision(((self.total_item_price * 12)/100).round(2), :precision => 2)
    else
      0.00
    end
  end

  def education_cess
    ((self.service_tax * 2)/100).round(2)
  end

  def higher_education_cess
    ((self.service_tax * 1)/100).round(2)
  end





  def is_invoice_being_raised?
    self.status == STATUS_INVOICE && self.status_changed?
  end



# Is Invoice Being Raised

  def is_proforma_invoice_being_raised?
    self.status == STATUS_INVOICE && self.invoice_type == INVOICE_PROFORMA && self.status_changed?
  end

  def is_tax_invoice_being_raised?
    self.status == STATUS_INVOICE && self.status_changed? && self.invoice_type == INVOICE_TAX
  end

  def is_tax_exempted_invoice_being_raised?
    self.status == STATUS_INVOICE && self.invoice_type == INVOICE_TAX_EXEMPTED && self.status_changed?
  end


# Is proforma invoice being converted to (Tax Invoice or Tax Exempted Invoice)

  def is_proforma_invoice_being_converted_to_tax_invoice?
    self.status == STATUS_INVOICE &&  self.invoice_type == INVOICE_TAX && self.invoice_type_changed?
  end

  def is_proforma_invoice_being_converted_to_tax_exempted_invoice?
    self.status == STATUS_INVOICE &&  self.invoice_type == INVOICE_TAX_EXEMPTED && self.invoice_type_changed?
  end



# Has invoice been raised already ?

  def is_a_complete_tax_invoice?
    self.status == STATUS_INVOICE && self.invoice_type == INVOICE_TAX
  end

  def is_a_complete_tax_exempted_invoice?
    self.status == STATUS_INVOICE && self.invoice_type == INVOICE_TAX_EXEMPTED
  end

  def is_a_complete_proforma_invoice?
    self.status == STATUS_INVOICE && self.invoice_type == INVOICE_PROFORMA
  end



# Is the quotation still open for edits

  def is_open_for_edits(usr)
    self.status != STATUS_INVOICE || (self.invoice_type == INVOICE_PROFORMA && usr.is_admin?)
  end




  def update_invoice_details

    if is_invoice_being_raised?
      self.service_tax = 0.0
      self.invoice_raised_date = Date.today
      self.invoice_raised_by = User.current_user.email
    end

    if self.is_tax_invoice_being_raised?           ||
        self.is_tax_exempted_invoice_being_raised? ||
        self.is_proforma_invoice_being_converted_to_tax_invoice? ||
        self.is_proforma_invoice_being_converted_to_tax_exempted_invoice?

      self.invoice_number = self.invoice_number.nil? ? Quotation.maximum('invoice_number').to_i + 1 : self.invoice_number;
      self.invoice_raised_date = Date.today
      self.invoice_raised_by = User.current_user.email

    end

    if is_tax_invoice_being_raised? || is_proforma_invoice_being_converted_to_tax_invoice?
      self.service_tax = ((total_item_price * 12.36)/100).round(2)
    end
  end



  def clone_with_associations
    @new_quotation = self.dup
    @new_quotation.status = STATUS_PENDING
    @new_quotation.event_name = '[DUPLICATE] ' + self.event_name
    @new_quotation.invoice_number=nil
    @new_quotation.event_date = DateTime.now.to_date
    @new_quotation.invoice_raised_date = nil
    @new_quotation.payment_received_in_full = nil
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
