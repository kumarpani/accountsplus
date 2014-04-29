module PrintQuotationsHelper

  def get_header_for_print_quotation(quotation)
    if quotation.is_a_complete_tax_invoice? || quotation.is_a_complete_tax_exempted_invoice?
      'Tax Invoice'
    elsif quotation.is_a_complete_proforma_invoice?
      'Proforma Invoice'
    else
      'Quotation'
    end

  end

  def get_display_date(quotation)
    if quotation.invoice_raised_date.nil?
      quotation.updated_at
    else
      quotation.invoice_raised_date
    end
  end

end
