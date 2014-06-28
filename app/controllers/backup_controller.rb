class BackupController < ApplicationController
  def backup_data

    @backup = Backup.new

    authorize @backup

    zipfile = "backup_" + DateTime.now.strftime("%H%M%s") + ".zip"
    t = Tempfile.new(zipfile, Rails.root.join('tmp'))


    Zip::OutputStream.open(t.path) do |z|
      Client.select {|client| client.created_at >= params[:start_date] and client.created_at <= params[:end_date]}.each do |c|

        file_name = "#{c.company_name}.xlsx"
        p = Axlsx::Package.new
        wb = p.workbook
        p.use_shared_strings = true

        add_client_sheet(c, wb)
        add_payments_sheet(c.id, wb, params[:start_date], params[:end_date])

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

    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "backup.zip"

  end

  private def add_client_sheet(c, wb)
    wb.add_worksheet(name: "Clients") do |sheet|
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

      Payment.select {|p| p.client_id == client_id && p.created_at >= start_date && p.created_at <= end_date}.sort_by { |p| p[:updated_at] }.reverse.each do |p|

        sheet.add_row [p.id, p.client_id, p.quotation_id, p.paid_on.strftime('%d/%m/%Y'), p.description, p.mode, p.reference_number, p.amount,
                          p.payment_type, p.received_by, p.payment_added_by, p.payment_last_modified_by,
                          p.created_at, p.updated_at],
                      types: [:string, :string, :string, :string, :string, :string, :string, :string,
                              :string, :string, :string, :string, :string, :string]

      end

    end
  end


end
