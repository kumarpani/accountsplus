class LedgersController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @ledger_details = Ledger.new.index(params[:start_date].to_s, params[:end_date].to_s, params[:client_id])
  end

  def print
    respond_to do |format|
      format.pdf do
        pdf = PrintLedger.new(params[:start_date].to_s, params[:end_date].to_s, params[:client_id], params[:company_name])
        send_data pdf.render, filename: "ledger.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


end
