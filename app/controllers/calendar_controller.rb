class CalendarController < ApplicationController
  def index
    @all_quotations = Quotation.where.not(status: 'Closed')
  end
end
