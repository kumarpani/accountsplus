class IncomingServiceTax < ActiveRecord::Base
  def index(s_date, e_date)
    if !s_date.to_s.empty? && !e_date.to_s.empty?
      @s_date = Date.parse(s_date, '%d/%m/%Y')
      @e_date = Date.parse(e_date, '%d/%m/%Y')

      @bank = IncomingServiceTax.where('invoice_date >= ? AND invoice_date <= ?',  @s_date, @e_date).order(:invoice_date)
    end
  end

end
