class PrintLedgerController < ApplicationController
  layout 'print'

  def index
    @ledger_details = params[:ledger_details]
  end

end
