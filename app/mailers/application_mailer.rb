class ApplicationMailer < ActionMailer::Base
  def send_backup_mail(to, path, start_date, end_date)

    name = ApplicationHelper::NAME + ' Backup From ' + start_date + ' To ' + end_date
    zip_file_name = name + '.zip'

    attachments[zip_file_name] = File.read(path)

    mail(:from => 'queries.sulabha.sw.in@gmail.com', :to => to,
                                   :subject => name,
                                   :body => '')

  end
end