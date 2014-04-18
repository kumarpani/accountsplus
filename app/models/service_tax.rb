class ServiceTax

  def index(s_date, e_date)
      if !s_date.to_s.empty? && !e_date.to_s.empty?
        @s_date = Date.parse(s_date, '%d/%m/%Y')
        @e_date = Date.parse(e_date, '%d/%m/%Y')

        Quotation.where('invoice_type IN (?, ?) AND status = ? AND invoice_raised_date >= ? AND invoice_raised_date <= ?',
                        INVOICE_TAX, INVOICE_TAX_EXEMPTED, STATUS_INVOICE, @s_date, @e_date).order(:invoice_number)
      end
    end
end

