class BackupController < ApplicationController
  def backup_data

    @backup = Backup.new

    authorize @backup
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
