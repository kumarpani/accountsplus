class BankController < ApplicationController

  def index
    @bank = Bank.new.index(params[:start_date], params[:end_date])
  end

end
