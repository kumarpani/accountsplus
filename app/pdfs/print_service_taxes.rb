class PrintServiceTaxes < PrintBase

  include ApplicationHelper

  def initialize(start_date, end_date)
    super()
    tax = ServiceTax.new.index(start_date, end_date)

    if !start_date.to_s.empty? && !:end_date.to_s.empty?
      header(start_date, end_date)
    end

    taxes_table(tax, start_date)

  end

  def header(start_date, end_date)
    text("Service Tax details between : #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
    text "\n"
  end

  def taxes_table(tax, start_date)
       if Date.parse(start_date) >= Date.new(2017, 7, 1)
          data =  [[
                 {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Number', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Date', :font_style => :bold, :align => :center},
                 {:content => 'Name', :font_style => :bold, :align => :center},
                 {:content => 'Grand Total', :font_style => :bold, :align => :center},
                 {:content => 'CGST', :font_style => :bold, :align => :center},
                 {:content => 'SGST', :font_style => :bold, :align => :center}
             ]]

       else
         data =  [[
                      {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                      {:content => 'Invoice Number', :font_style => :bold, :align => :center},
                      {:content => 'Invoice Date', :font_style => :bold, :align => :center},
                      {:content => 'Name', :font_style => :bold, :align => :center},
                      {:content => 'Grand Total', :font_style => :bold, :align => :center},
                      {:content => 'Service Tax', :font_style => :bold, :align => :center}
                ]]
       end


    tax.each_with_index do |t, index|

        if Date.parse(start_date) >= Date.new(2017, 7, 1)
          data += [[
                      {:content => "#{index+1}", :align => :center},
                      {:content =>"#{t.invoice_number}", :align => :center},
                      {:content =>"#{display_date(t.invoice_raised_date)}"},
                      {:content => "#{get_company_name_by_client_id(t.client_id)}"},
                      {:content =>"#{get_total_by_quotation_id(t.id)}", :align => :right},
                      {:content => "#{ApplicationController.helpers.number_with_precision(t.service_tax/2, :precision => 2)}"},
                      {:content => "#{ApplicationController.helpers.number_with_precision(t.service_tax/2, :precision => 2)}"}
                     ]]
                   else
                     data += [[
                                  {:content => "#{index+1}", :align => :center},
                                  {:content =>"#{t.invoice_number}", :align => :center},
                                  {:content =>"#{display_date(t.invoice_raised_date)}"},
                                  {:content => "#{get_company_name_by_client_id(t.client_id)}"},
                                  {:content =>"#{get_total_by_quotation_id(t.id)}", :align => :right},
                                  {:content =>"#{t.service_tax}", :align => :right}
                              ]]
                   end
    end


    if Date.parse(start_date) >= Date.new(2017, 7, 1)
      data += [[
                   "",
                   "",
                   "",
                   {:content => 'Total:', :font_style => :bold},
                   {:content => "#{tax.sum(&:total_price)}", :font_style => :bold, :align => :right},
                   {:content => "#{ApplicationController.helpers.number_with_precision(tax.sum(&:service_tax)/2, :precision => 2)}", :font_style => :bold, :align => :right},
                   {:content => "#{ApplicationController.helpers.number_with_precision(tax.sum(&:service_tax)/2, :precision => 2)}", :font_style => :bold, :align => :right}
               ]]
    else
      data +=  [[
                    "",
                    "",
                    "",
                    {:content => 'Total:', :font_style => :bold},
                    {:content => "#{tax.sum(&:total_item_price)}", :font_style => :bold, :align => :right},
                    {:content => "#{tax.sum(&:service_tax)}", :font_style => :bold, :align => :right}
                ]]
    end


    if Date.parse(start_date) >= Date.new(2017, 7, 1)

      table(data, :column_widths => {0 => 40,1 => 50,2 => 60,3 => 170, 4 => 50, 5 => 40, 6 => 40},
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})
    else

      table(data, :column_widths => {0 => 40,1 => 50,2 => 60,3 => 200, 4 => 60, 5 => 60},
        :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})
    end
  end
end