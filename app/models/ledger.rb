class Ledger

  def index(s_date, e_date, client_id)

    @ledger_details = get_ledger(client_id)

    balance = 0.0;
    @ledger_details = @ledger_details.map { |l|
      balance = l[:balance] = balance - (l[:debit] || 0.0) + (l[:credit] || 0.0)
      l
    }

    #Apply date start date and end date filters
    if s_date != "" && e_date != ""
      @st_date = Date.parse(s_date, '%d/%m/%Y')
      @ed_date = Date.parse(e_date, '%d/%m/%Y')

      @ledger_details = @ledger_details.select{|l| l[:date] >= @st_date and l[:date] <= @ed_date}

    else
      @ledger_details = @ledger_details.select {|l| l[:date]}
    end
  end

  def get_ledger(client_id)
    @client = Client.find(client_id)

    @ledger_details = @client.quotations.keep_if { |q| q.status == STATUS_INVOICE }.map { |q|
      {date: q.event_date, description: q.event_name, venue: q.venue, invoice_number: q.invoice_number, credit: q.total_price, id: q.id}
    };

    @ledger_details = @ledger_details + @client.payments.map { |p|
      payment = {date: p.paid_on, description: (p.description || '') + ' ' + (p.mode || '')}
      payment[p.payment_type.downcase.to_sym] = p.amount
      payment
    }

    @ledger_details = @ledger_details + @client.incoming_service_taxes.map { |i|
      ist = {date: i.invoice_date, description: ('InComing Service Tax: ') + (i.description || '')}
      ist[:debit] = i.event_total
      ist
    }

    @ledger_details.sort_by! { |l| l[:date] }
  end

  def get_ledger_balance(client_id)
    @ledger_details = get_ledger(client_id)

    balance = 0.0;
    @ledger_details = @ledger_details.map { |l|
      balance = l[:balance] = balance - (l[:debit] || 0.0) + (l[:credit] || 0.0)
      l
    }
    balance
  end

end

