class BackupController < ApplicationController
  def backup_data

    @backup = Backup.new

    authorize @backup

    zipfile = "backup_" + DateTime.now.strftime("%H%M%s") + ".zip"
    t = Tempfile.new(zipfile, Rails.root.join('tmp'))


    Zip::OutputStream.open(t.path) do |z|
      Client.select {|client| client[:created_at] >= params[:start_date] and client[:created_at] <= params[:end_date]}.each do |c|

        file_name = "#{c.company_name}.xlsx"
        p = Axlsx::Package.new
        wb = p.workbook
        p.use_shared_strings = true
        wb.add_worksheet(name: "Clients") do |sheet|
          sheet.add_row [c.id, c.company_name], types: [:string, :string]
        end
        p.serialize(file_name)
        z.put_next_entry(file_name)
        z.write File.open(file_name,"rb").read
        File.delete(file_name)

      end

    end

    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "backup.zip"


    #redirect_to(backup_data)

    #file_list = []
    #Client.select {|c| c[:created_at] >= params[:start_date] and c[:created_at] <= params[:end_date]}.each do |cl|
    #  p = Axlsx::Package.new
    #  wb = p.workbook
    #  wb.add_worksheet(name: "Clients") do |sheet|
    #    sheet.add_row [cl.id]
    #  end
    #  file_name = "#{cl.id}.xlsx"
    #  file_list << file_name
    #  p.serialize(file_name)
    #end
    #Zip::File.open("clients.zip",Zip::File::CREATE) do |zipFile|
    #  file_list.each do |file_name|
    #    p file_name
    #    zipFile.add(file_name,file_name)
    #  end
    #end
    #
    #send_file "clients.zip"
  end

end
