class LedgersController < ApplicationController
  before_action :set_ledger, only: [:show, :edit, :update, :destroy]
  before_filter :load_client

  # GET /ledgers
  # GET /ledgers.json
  def index
    @ledger_details = @client.quotations.keep_if { |q| q.status == INVOICE }.map { |q|
      {date: q.event_date, description: q.event_name, credit: q.total_price, id:q.id }
    };
    @ledger_details = @ledger_details + @client.payments.keep_if { |p| p.item_detail.nil? || p.item_detail.quotation.status == INVOICE }.map { |p|
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

    @ledger_details = @ledger_details.sort_by {|l| l[:date]}

  #  Apply date start date and end date filters
    if !params[:start_date].to_s.empty? && !params[:end_date].to_s.empty?
      @s_date = Date.parse(params[:start_date], '%d/%m/%Y')
      @e_date = Date.parse(params[:end_date], '%d/%m/%Y')

      @ledger_details = @ledger_details.select{|l| l[:date] >= @s_date and l[:date] <= @e_date}
    end

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
