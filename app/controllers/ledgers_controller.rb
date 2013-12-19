class LedgersController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @ledger_details = Ledger.new.index(params[:start_date].to_s, params[:end_date].to_s, params[:client_id])
  end

 end
