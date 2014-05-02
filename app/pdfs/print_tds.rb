class PrintTds < PrintBase

  include ApplicationHelper

  def initialize(start_date, end_date)
    super()
    tds = Tds.new.index(start_date, end_date)

    if !start_date.to_s.empty? && !:end_date.to_s.empty?
      header(start_date, end_date)
    end

    taxes_table(tds)

  end

  def header(start_date, end_date)
    text("TDS between : #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
    text "\n"
  end

  def taxes_table(tds)
    data =  [[
                 {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                 {:content => 'Client Name', :font_style => :bold, :align => :center},
                 {:content => 'Paid On', :font_style => :bold, :align => :center},
                 {:content => 'Amount', :font_style => :bold, :align => :center},
             ]]

    tds.each_with_index do |t, index|

        data += ([[{:content => "#{index+1}", :align => :center},
                   {:content => "#{get_company_name_by_client_id(t.client_id)}"},
                   {:content =>"#{display_date(t.paid_on)}"},
                   {:content =>"#{t.amount}", :align => :right},
                  ]])
    end

    data +=  [[
                 "",
                 "",
                 {:content => 'Total:', :font_style => :bold},
                 {:content => "#{tds.sum(&:amount)}", :font_style => :bold, :align => :right}
             ]]

    table(data, :column_widths => {0 => 40,1 => 250,2 => 60,3 => 65},
        :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})

  end
end