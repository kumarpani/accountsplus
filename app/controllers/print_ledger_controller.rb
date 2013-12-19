class PrintLedgerController < ApplicationController
  layout 'print'

  def index
    @ledger_details = Ledger.new.index(params[:start_date], params[:end_date], params[:client_id])
  end

end
