class PrintTdsController < ApplicationController
  layout 'print'

  def index
    @tds = Tds.new.index(params[:start_date], params[:end_date])

  end
end
