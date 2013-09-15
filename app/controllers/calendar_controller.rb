class CalendarController < ApplicationController
  def index
    @confirmed_quotations = Quotation.where(status: 'Confirmed')
  end
end
