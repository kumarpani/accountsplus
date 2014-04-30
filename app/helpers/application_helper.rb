module ApplicationHelper

  # Application Title and Name
  TITLE = 'Audioplus'
  NAME = 'Audio Plus'

  # Address
  ADD_LINE1 = 'U-26, 3rd Cross, Pipeline,'
  ADD_LINE2 = 'Krishnappa Block, Malleshwaram,'
  ADD_LINE3 = 'Bangalore - 5600 03'
  TELEPHONE = '080 23567619'
  MOBILE = '98802 73773'
  EMAIL = 'audioplus.events@gmail.com'

  #Bank Details
  BANK_ACC_NAME = 'Audioplus'
  BANK_NAME_BRANCH = 'HDFC Bank Ltd, Seshadripuram'
  BANK_ACC_NUM = '03672020000887'
  BANK_TYPE_OF_ACC = 'Current Account'
  BANK_IFSC = 'HDFC0000367'
  BANK_MIRC = '560240018'

  #Service Tax Number
  PAN_NUMBER = ''
  SERVICE_TAX_NUMBER = 'AKAPP9970EST001'
  SERVICE_CATEGORY = ''



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
