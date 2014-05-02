class ServiceTaxesController < ApplicationController

  def index
    @service_tax = ServiceTax.new.index(params[:start_date], params[:end_date])
  end

  def print
    respond_to do |format|
      format.pdf do
        pdf = PrintServiceTaxes.new(params[:start_date], params[:end_date])
        send_data pdf.render, filename: "service_taxes.pdf",
                  type: "application/pdf",
                  disposition: "inline"
      end
    end
  end


end
