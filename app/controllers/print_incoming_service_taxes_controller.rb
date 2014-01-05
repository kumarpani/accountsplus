class PrintIncomingServiceTaxesController < ApplicationController
  layout 'print'

  def index
    @incoming_service_taxes = IncomingServiceTax.new.index(params[:start_date], params[:end_date])
  end

end
