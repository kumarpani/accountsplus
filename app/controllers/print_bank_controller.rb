class PrintBankController < ApplicationController
  layout 'print'

  def index
    @bank = Bank.new.index(params[:start_date], params[:end_date])
  end
end
