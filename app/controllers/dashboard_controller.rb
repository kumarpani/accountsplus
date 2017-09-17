class DashboardController < ApplicationController

  def index

    @upcoming_quotations = Quotation.where('event_date >= ? AND status = ?', Date.today, STATUS_CONFIRMED).order('event_date ASC')

  end
end
