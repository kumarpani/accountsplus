class ServiceTaxesController < ApplicationController

  def index
    @service_tax = ServiceTax.new.index(params[:start_date], params[:end_date])
  end

end
