module ApplicationHelper

  # Application Title and Name
  TITLE = 'AccountsDemo'
  NAME = 'Accounts Demo'

  # Address
  ADD_LINE1 = 'Address line 1'
  ADD_LINE2 = 'Address line 2'
  ADD_LINE3 = 'City'
  TELEPHONE = '888 88888888'
  MOBILE = '99999 99999'
  EMAIL = 'your_email@your_domain.com'

  #Bank Details
  BANK_ACC_NAME = 'Account Name'
  BANK_NAME_BRANCH = 'Bank Name and Branch'
  BANK_ACC_NUM = 'Account Number'
  BANK_TYPE_OF_ACC = 'Account Type'
  BANK_IFSC = 'IFSC Code'
  BANK_MIRC = 'MIRC Code'

  #Service Tax Number
  PAN_NUMBER = ''
  SERVICE_TAX_NUMBER = 'Service Tax Number'
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
