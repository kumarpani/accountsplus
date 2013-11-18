module PaymentsHelper
  def get_header_for_payments(client_id, company_name)
    if client_id.nil?
      'All Payments'
    else
      'Payments for ' + company_name
    end
  end

end
