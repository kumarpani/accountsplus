class BackupController < ApplicationController
  def backup_data

    @backup = Backup.new

    authorize @backup

    zipfile = "backup_" + DateTime.now.strftime("%H%M%s") + ".zip"
    t = Tempfile.new(zipfile, Rails.root.join('tmp'))

    Thread.new do

        Zip::OutputStream.open(t.path) do |z|
          Client.all.each do |c|

            file_name = "#{c.company_name}.xlsx"
            p = Axlsx::Package.new
            wb = p.workbook
            p.use_shared_strings = true

            add_client_sheet(c, wb)
            add_invoices_sheet(c.id, wb, params[:start_date], params[:end_date])
            add_payments_sheet(c.id, wb, params[:start_date], params[:end_date])
            add_ledger_sheet(c.id, wb, params[:start_date], params[:end_date])
            add_ist_sheet(c.id, wb, params[:start_date], params[:end_date])

            tempfile_new = Tempfile.new(file_name, Rails.root.join('tmp'))
            p.serialize(tempfile_new)
            z.put_next_entry(file_name)
            File.open(tempfile_new,"rb") do |f|
              z.write f.read
            end
            File.delete(tempfile_new)

          end

        end
        t.close

        #send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "backup.zip"
        mail = ActionMailer::Base.mail(:from => 'queries.sulabha.sw.in@gmail.com', :to => current_user.email,
                                       :subject => 'Test',
                                       :body => 'Test Body',
                                       :content_type => 'multipart/mixed')
        mail.attachments[zipfile] = open(t.path).read
        mail.deliver
        FileUtils.rm(t.path)

    end
  end


  private def add_client_sheet(c, wb)
    wb.add_worksheet(name: "Client") do |sheet|
      sheet.add_row ['ID', c.id], types: [:string, :string]
      sheet.add_row ['Company Name', c.company_name], types: [:string, :string]
      sheet.add_row ['Contact Person Name', c.contact_person_name], types: [:string, :string]
      sheet.add_row ['Address', c.address], types: [:string, :string]
      sheet.add_row ['Phone Number', c.phone_number], types: [:string, :string]
      sheet.add_row ['Phone number 2', c.phone_number_1], types: [:string, :string]
      sheet.add_row ['Email', c.email], types: [:string, :string]
      sheet.add_row ['Email 2', c.email_1], types: [:string, :string]
    end
  end

  private def add_payments_sheet(client_id, wb, start_date, end_date)
    wb.add_worksheet(name: "Payments") do |sheet|

      sheet.add_row ['ID', 'Client ID', 'Quotation ID', 'Paid On', 'Description', 'Mode', 'Reference Number', 'Amount',
                        'Payment Type', 'Received By', 'Payment Added By', 'Payment Last Modified By',
                        'Created At', 'Updated At'],
                    types: [:string, :string, :string, :string, :string, :string, :string, :string,
                            :string, :string, :string, :string, :string, :string]

      Payment.select {|p| p.client_id == client_id && p.created_at >= start_date && p.created_at <= end_date}
             .sort_by { |p| p[:updated_at] }.reverse.each do |p|

        sheet.add_row [p.id, p.client_id, p.quotation_id, p.paid_on.strftime('%d/%m/%Y'), p.description, p.mode, p.reference_number, p.amount,
                          p.payment_type, p.received_by, p.payment_added_by, p.payment_last_modified_by,
                          p.created_at, p.updated_at],
                      types: [:string, :string, :string, :string, :string, :string, :string, :string,
                              :string, :string, :string, :string, :string, :string]

      end

    end
  end

  private def add_ledger_sheet(client_id, wb, start_date, end_date)
    wb.add_worksheet(name: "Ledger") do |sheet|

      sheet.add_row ['Client ID', 'Date', 'Description Of Transaction', 'Invoice Number', 'Debit', 'Credit', 'Balance'],
                    types: [:string, :string, :string, :string, :string, :string, :string]

      @ledger_details = Ledger.new.index(start_date.to_s, end_date.to_s, client_id)

      @ledger_details.each do |l|
        sheet.add_row [client_id, l[:date].strftime('%d/%m/%Y'), l[:description], l[:invoice_number], l[:debit], l[:credit], l[:balance]],
                      types: [:string, :string, :string, :string, :string, :string, :string]
      end

    end
  end

  private def add_ist_sheet(client_id, wb, start_date, end_date)
    wb.add_worksheet(name: "Incoming Service Taxes") do |sheet|

      sheet.add_row ['ID', 'Client ID', 'Invoice Number', 'Invoice Date', 'Description',
                          'Event Total', 'Service Tax', 'Created At', 'Updated At'],
                    types: [:string, :string, :string, :string, :string, :string, :string, :string, :string]

      IncomingServiceTax.select {|i| i.client_id == client_id.to_s && i.created_at >= start_date && i.created_at <= end_date}
                        .sort_by { |i| i[:invoice_date] }.each do |i|

        sheet.add_row [i.id, i.client_id, i.invoice_number, i.invoice_date.strftime('%d/%m/%Y'), i.description,
                          i.event_total, i.service_tax, i.created_at, i.updated_at],
                      types: [:string, :string, :string, :string, :string, :string, :string, :string, :string]

      end

    end
  end


  private def add_invoices_sheet(client_id, wb, start_date, end_date)
    wb.add_worksheet(name: "Invoices") do |sheet|

      Quotation.select {|q| q.client_id == client_id && q.status == STATUS_INVOICE && q.created_at >= start_date && q.created_at <= end_date}
            .sort_by { |q| q[:created_at] }.each do |q|

        sheet.add_row ['ID', q.id, '', 'Client Id', q.client_id], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['Event Name', q.event_name, '', 'Venue', q.venue], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['Event Date', q.event_date.strftime('%d/%m/%Y'), '', 'Days', q.days], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['Invoice Type', q.invoice_type, '', 'Status', q.status], types: [:string, :string, :string, :string, :string]
        ird = ''
        if !q.invoice_raised_date.nil?
          ird = q.invoice_raised_date.strftime('%d/%m/%Y')
        end

        sheet.add_row ['Invoice Number', q.invoice_number, '', 'Invoice Raised Date', ird], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['Order Placed By', q.order_placed_by, '', 'Invoice Raised By', q.invoice_raised_by], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['Created At', q.created_at, '', 'Updated At', q.updated_at], types: [:string, :string, :string, :string, :string]
        sheet.add_row ['notes', q.notes], types: [:string, :string]
        sheet.add_row ['Terms and Conditions', q.tac], types: [:string, :string]

        sheet.add_row [''], types: [:string]

        add_item_details(q, sheet)

        sheet.add_row [''], types: [:string]
        sheet.add_row [''], types: [:string]
        sheet.add_row [''], types: [:string]


      end

    end
  end


  private def add_item_details(q, sheet)
    sheet.add_row ['ID', 'Particulars', 'Quantity', 'Days', 'Unit Price', 'Price', 'Item Group Name']

    q.item_details.sort_by {|i| i[:item_group_name]}.each do |i|
      sheet.add_row [i.id, i.particulars, i.quantity, i.days,
                     i.unit_price, i.price, i.item_group_name],
                    types: [:string, :string, :string, :string, :string, :string, :string]
    end

    sheet.add_row ['', 'Total:', '', '', '', ApplicationController.helpers.number_with_precision(q.total_item_price, :precision => 2)],
        types: [:string, :string, :string, :string, :string, :string]

    if q.is_a_complete_tax_invoice? || q.is_a_complete_tax_exempted_invoice?
      sheet.add_row ['', 'Service Tax @ 12%', '', '', '', q.service_tax_at_12_percent],
                    types: [:string, :string, :string, :string, :string, :string]
      sheet.add_row ['', 'Education Cess @ 2% (On S.T)', '', '', '', q.education_cess],
                    types: [:string, :string, :string, :string, :string, :string]
      sheet.add_row ['', 'Sec. & Higher Edu. Cess @ 1% (On S.T)', '', '', '', q.higher_education_cess],
                    types: [:string, :string, :string, :string, :string, :string]
      sheet.add_row ['', 'Total with taxes (rounded off):', '', '', '', ApplicationController.helpers.number_with_precision(q.total_price, :precision => 2)],
                    types: [:string, :string, :string, :string, :string, :string]

    end
  end

end
