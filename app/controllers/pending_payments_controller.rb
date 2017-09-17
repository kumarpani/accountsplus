class PendingPaymentsController < ApplicationController

  def index

    @pending_payments = Client.all.map {|c|
       {
           client: c,
           owes: Ledger.new.get_ledger_balance(c.id)
       }
    }.select { |p| p[:owes] != 0.0 }

    @pending_payments = @pending_payments.sort_by {|o| o[:owes]}.reverse
  end
end
