class PrintServiceTaxesController < ApplicationController
  layout 'print'

  def index
    @service_tax = ServiceTax.new.index(params[:start_date], params[:end_date])
  end
end
