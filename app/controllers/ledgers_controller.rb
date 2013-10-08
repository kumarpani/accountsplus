class LedgersController < ApplicationController
  before_action :set_ledger, only: [:show, :edit, :update, :destroy]
  before_filter :load_client

  # GET /ledgers
  # GET /ledgers.json
  def index
    @ledger_details = @client.quotations.keep_if { |q| q.status == 'Confirmed' }.map { |q|
      {date: q.created_at, description: q.name, credit: q.total_price}
    };
    @ledger_details = @ledger_details + @client.payments.keep_if { |p| p.item_detail.nil? || p.item_detail.quotation.status == 'Confirmed' }.map { |p|
      payment = {date: p.paid_on, description: (p.description || '') + (p.mode || '')}
      payment[p.payment_type.downcase.to_sym] = p.amount
      payment
    }
    @ledger_details.sort_by! { |l| l[:date] }
    balance = 0.0;
    @ledger_details = @ledger_details.map { |l|
      balance = l[:balance] = balance - (l[:debit] || 0.0) + (l[:credit] || 0.0)
      l
    }
  end

  private
  def load_client
    @client = Client.find(params[:client_id])
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def ledger_params
    params[:ledger]
  end
end
