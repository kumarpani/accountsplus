class PrintServiceTaxes < PrintBase

  include ApplicationHelper

  def initialize(start_date, end_date)
    super()
    tax = ServiceTax.new.index(start_date, end_date)

    if !start_date.to_s.empty? && !:end_date.to_s.empty?
      header(start_date, end_date)
    end

    taxes_table(tax)

  end

  def header(start_date, end_date)
    text("Service Tax details between : #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
    text "\n"
  end

  def taxes_table(tax)
    data =  [[
                 {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Number', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Date', :font_style => :bold, :align => :center},
                 {:content => 'Name', :font_style => :bold, :align => :center},
                 {:content => 'Event Total', :font_style => :bold, :align => :center},
                 {:content => 'Service Tax', :font_style => :bold, :align => :center},
             ]]

    tax.each_with_index do |t, index|

        data += ([[{:content => "#{index+1}", :align => :center},
                   {:content =>"#{t.invoice_number}", :align => :center},
                   {:content =>"#{display_date(t.invoice_raised_date)}"},
                   {:content => "#{get_company_name_by_client_id(t.client_id)}"},
                   {:content =>"#{get_total_item_price_by_quotation_id(t.id)}", :align => :right},
                   {:content =>"#{t.service_tax}", :align => :right},
                  ]])
    end

    data +=  [[
                 "",
                 "",
                 "",
                 {:content => 'Total:', :font_style => :bold},
                 {:content => "#{tax.sum(&:total_item_price)}", :font_style => :bold, :align => :right},
                 {:content => "#{tax.sum(&:service_tax)}", :font_style => :bold, :align => :right}
             ]]

    table(data, :column_widths => {0 => 40,1 => 50,2 => 60,3 => 180, 4 => 60, 5 => 60},
        :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})

  end
end