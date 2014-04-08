class TdsController < ApplicationController
  def index
    @tds = Tds.new.index(params[:start_date], params[:end_date])

  end
end
