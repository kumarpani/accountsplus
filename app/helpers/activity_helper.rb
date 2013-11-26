module ActivityHelper
  def get_dates_message(start_date, end_date)

    message = ''

    if start_date.nil? || start_date == ''
        message += display_verbose_date(Date.yesterday)
    else
        message += display_verbose_date(start_date)
    end

    message += ' | '

    if end_date.nil? || start_date == ''
        message += display_verbose_date(Date.today)
    else
        message += display_verbose_date(end_date)
    end

    message

  end
end
