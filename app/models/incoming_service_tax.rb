class IncomingServiceTax < ActiveRecord::Base

  validates_presence_of :client_id, :event_total, :invoice_date, :invoice_number

  after_initialize :init

  def init
    self.service_tax ||= 0
    self.cgst ||=0
    self.sgst ||=0
  end

  def index(s_date, e_date)
    if !s_date.to_s.empty? && !e_date.to_s.empty?
      @s_date = Date.parse(s_date, '%d/%m/%Y')
      @e_date = Date.parse(e_date, '%d/%m/%Y')

      IncomingServiceTax.where('invoice_date >= ? AND invoice_date <= ?',  @s_date, @e_date).order(:invoice_date)
    end
  end

end
