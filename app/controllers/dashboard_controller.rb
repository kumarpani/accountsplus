class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @upcoming_quotations = Quotation.where('event_date >= ? AND status == ?', Date.today, CONFIRMED).order('event_date ASC')
    @pending_payments = Quotation.where(status: INVOICE).group(:client_id).map { |quot|
      {client: quot.client,
       owes: quot.client.quotations
       .select { |q| q.status == INVOICE }
       .sum { |q| q.total_price } -
           quot.client.payments.sum { |p| p.amount }} }
    .select { |p| p[:owes] != 0.0 }
  end
end
