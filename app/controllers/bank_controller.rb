class BankController < ApplicationController
  def index
    if !params[:start_date].to_s.empty? && !params[:end_date].to_s.empty?
      @s_date = Date.parse(params[:start_date], '%d/%m/%Y')
      @e_date = Date.parse(params[:end_date], '%d/%m/%Y')

      @bank = Quotation.where('invoice_type = ? AND status = ? AND invoice_raised_date >= ? AND invoice_raised_date <= ?', INVOICE, INVOICE, @s_date, @e_date)
    end
  end
end
