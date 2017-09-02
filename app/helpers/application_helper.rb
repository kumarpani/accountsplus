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

  # GST
  GSTIN = '29AKAPP9970E1ZQ'
  STATE_CODE = '29'

  #Service Tax Number
  PAN_NUMBER = ''
  SERVICE_TAX_NUMBER = 'AKAPP9970EST001'
  SERVICE_CATEGORY = ''

  BANKS = [Bank.new('HDFC', 'HDFC Bank Ltd', 'Seshadripuram', 'HDFC0000367', '560240018', 'Audioplus', '03672020000887', 'Current Account'),
           Bank.new('CANARA' ,'CANARA Bank', 'Malleswaram', 'CNRB0000409', '560015072', 'Audioplus', '0409201004561', 'Current Account')]

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
