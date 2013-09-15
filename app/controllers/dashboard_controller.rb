class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @upcoming_quotations = Quotation.where("event_date >= ? AND status == 'Confirmed'", Date.today).order("event_date ASC")
  end
end
