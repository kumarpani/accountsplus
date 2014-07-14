class Bank

  attr_reader :nick_name, :name, :branch, :ifsc, :mirc, :account_name, :account_number, :account_type

  def initialize(nick_name, name, branch, ifsc, mirc, account_name, account_number, account_type)
    @nick_name = nick_name
    @name = name
    @branch = branch
    @ifsc = ifsc
    @mirc = mirc
    @account_name = account_name
    @account_number = account_number
    @account_type = account_type
  end



end