module ApplicationHelper

  # Application Title and Name
  TITLE = 'TestVagrant'
  NAME = 'TestVagrant'

  # Address
  ADD_LINE1 = '462, 7th Main West Wing,'
  ADD_LINE2 = 'AmaraJyothi Layout,'
  ADD_LINE3 = 'Domlur, Bangalore - 560071'
  MOBILE = '98456 32084'
  EMAIL = 'info@testvagrant.com'


  #Service Tax Number
  PAN_NUMBER = ''
  SERVICE_TAX_NUMBER = 'YET_TO_BE_OBTAINED'
  SERVICE_CATEGORY = ''

  BANKS = [Bank.new('Kotak', 'Kotak Mahindra Bank Ltd', 'Indiranagar', 'KKBK0000431', '6011476025', 'TestVagrant', '', 'Current Account')
           ]

  def display_verbose_date(date)
    date.to_date.strftime('%d %B, %Y')
  end

  def display_date(date)
    date.strftime('%d/%m/%Y')
  end

  def get_company_name_by_client_id(client_id)
    Client.find(client_id).company_name
  end

  def get_total_item_price_by_quotation_id(quotation_id)
    Quotation.find(quotation_id).total_item_price
  end

  def get_all_sorted_companies
    Client.all.sort_by{|c| c.company_name.downcase}.map { |client| [client.company_name, client.id] }
  end

  def get_user_and_date
    current_user.first_name + ' | ' + display_verbose_date(DateTime.now)
  end

  def get_quotation_status_color_class_by_id(id)
    q = Quotation.find(id)
    q.payment_received_in_full ? 'Fulfilled' : q.status
  end

end
