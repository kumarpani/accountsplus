module ApplicationHelper

  # Application Title and Name
  TITLE = 'AV Creations'
  NAME = 'AV Creations'

  # Address
  ADD_LINE1 = '#6, 2rd Cross,'
  ADD_LINE2 = 'C.S.I. Compound, Mission Road'
  ADD_LINE3 = 'Bangalore - 5600 27'
  TELEPHONE = '4205 8284 / 4205 8479'
  MOBILE = '96864 54272/3/4'
  EMAIL = 'avcreations12@gmail.com'

  #Bank Details
  BANK_ACC_NAME = 'AV Creations'
  BANK_NAME_BRANCH = 'Indian Bank, Cubbonpet, Bangalore'
  BANK_ACC_NUM = '860986003'
  BANK_TYPE_OF_ACC = 'Current Account'
  BANK_IFSC = 'IDIB 000C107'
  BANK_MIRC = ''

  #Service Tax Number
  PAN_NUMBER = 'AAQFA7787E'
  SERVICE_TAX_NUMBER = 'AAQFA7787ESD001'
  SERVICE_CATEGORY = 'Event Management Service.'

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



end
