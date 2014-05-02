class TdsController < ApplicationController
  def index
    @tds = Tds.new.index(params[:start_date], params[:end_date])
  end

  def print
    respond_to do |format|
      format.pdf do
        pdf = PrintTds.new(params[:start_date], params[:end_date])
        send_data pdf.render, filename: "tds.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end

end
