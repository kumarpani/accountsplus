module PrintQuotationsHelper

  def get_display_date
    if @quotation.invoice_raised_date.nil?
      @quotation.updated_at
    else
      @quotation.invoice_raised_date
    end

  end

end
