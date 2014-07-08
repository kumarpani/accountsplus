module ApplicationHelper

  # Application Title and Name
  TITLE = 'AV Creations'
  NAME = 'AV Creations'

  # Address
  ADD_LINE1 = '#6, 2rd Cross,'
  ADD_LINE2 = 'C.S.I. Compound, Mission Road'
  ADD_LINE3 = 'Bangalore - 5600 27'
  TELEPHONE = ''
  MOBILE = '96864 54272/3/4'
  EMAIL = 'avcreations12@gmail.com'

  #Service Tax Number
  PAN_NUMBER = 'AAQFA7787E'
  SERVICE_TAX_NUMBER = 'AAQFA7787ESD001'
  SERVICE_CATEGORY = 'Event Management Service.'

  BANKS = [Bank.new('Indian', 'Indian Bank', 'Cubbonpet, Bangalore', 'IDIB 000C107', '', 'AV Creations', '860986003', 'Current Account')]

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
