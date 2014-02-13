class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tasks = Task.all.sort_by {|t| t[:created_at]}
    @upcoming_quotations = Quotation.where('event_date >= ? AND status = ?', Date.today, CONFIRMED).order('event_date ASC')
    @pending_payments = Quotation.select(:client_id).where(status: INVOICE).group(:client_id).map { |quot|
      {client: quot.client,
       owes: quot.client.quotations
       .select { |q| q.status == INVOICE }
       .sum { |q| q.total_price } -
           quot.client.payments.select{|d| d.payment_type == 'Debit'}.sum { |p| p.amount } +
           quot.client.payments.select{|c| c.payment_type == 'Credit'}.sum { |p| p.amount }
      }
    }
    .select { |p| p[:owes] != 0.0 }
    @pending_payments = @pending_payments.sort_by {|o| o[:owes]}.reverse
  end
end
