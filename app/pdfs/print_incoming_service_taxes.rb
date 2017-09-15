class PrintIncomingServiceTaxes < PrintBase

  include ApplicationHelper

  def initialize(start_date, end_date)
    super()
    taxes = IncomingServiceTax.new.index(start_date, end_date)

    if !start_date.to_s.empty? && !:end_date.to_s.empty?
      header(start_date, end_date)
    end

    taxes_table(taxes, start_date)

  end

  def header(start_date, end_date)
    if isGST(Date.parse(start_date))
          text("Incoming GST details between : #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
    else
          text("Incoming Service Tax details between : #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
    end
    text "\n"
  end

  def taxes_table(taxes, start_date)
    if isGST(Date.parse(start_date))
      data =  [[
                   {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                   {:content => 'Invoice Number', :font_style => :bold, :align => :center},
                   {:content => 'Invoice Date', :font_style => :bold, :align => :center},
                   {:content => 'Company Name', :font_style => :bold, :align => :center},
                   {:content => 'Description', :font_style => :bold, :align => :center},
                   {:content => 'Event Total', :font_style => :bold, :align => :center},
                   {:content => 'CGST', :font_style => :bold, :align => :center},
                   {:content => 'SGST', :font_style => :bold, :align => :center}
               ]]

    else
      data =  [[
                 {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Number', :font_style => :bold, :align => :center},
                 {:content => 'Invoice Date', :font_style => :bold, :align => :center},
                 {:content => 'Company Name', :font_style => :bold, :align => :center},
                 {:content => 'Description', :font_style => :bold, :align => :center},
                 {:content => 'Event Total', :font_style => :bold, :align => :center},
                 {:content => 'Service Tax', :font_style => :bold, :align => :center}
             ]]
    end


    taxes.each_with_index do |tax, index|
      if isGST(Date.parse(start_date))
        data += ([[{:content => "#{index+1}", :align => :center},
                   {:content =>"#{tax.invoice_number}", :align => :center},
                   {:content =>"#{display_date(tax.invoice_date)}", :align => :center},
                   {:content =>!tax.client_id.nil? ? "#{get_company_name_by_client_id(tax.client_id)}" : ''},
                   {:content =>"#{tax.description}"},
                   {:content =>"#{tax.event_total}", :align => :right},
                   {:content =>"#{tax.cgst}", :align => :right},
                   {:content =>"#{tax.sgst}", :align => :right}
                  ]])
      else

        data += ([[{:content => "#{index+1}", :align => :center},
                   {:content =>"#{tax.invoice_number}", :align => :center},
                   {:content =>"#{display_date(tax.invoice_date)}", :align => :center},
                   {:content =>!tax.client_id.nil? ? "#{get_company_name_by_client_id(tax.client_id)}" : ''},
                   {:content =>"#{tax.description}"},
                   {:content =>"#{tax.event_total}", :align => :right},
                   {:content =>"#{tax.service_tax}", :align => :right}
                  ]])
      end

    end

    if isGST(Date.parse(start_date))
      data +=  [[
                    "",
                    "",
                    "",
                    "",
                    {:content => 'Total:', :font_style => :bold},
                    {:content => "#{taxes.sum(&:event_total)}", :font_style => :bold, :align => :right},
                    {:content => "#{taxes.sum(&:cgst)}", :font_style => :bold, :align => :right},
                    {:content => "#{taxes.sum(&:sgst)}", :font_style => :bold, :align => :right}
                ]]

    else

      data +=  [[
                 "",
                 "",
                 "",
                 "",
                 {:content => 'Total:', :font_style => :bold},
                 {:content => "#{taxes.sum(&:event_total)}", :font_style => :bold, :align => :right},
                 {:content => "#{taxes.sum(&:service_tax)}", :font_style => :bold, :align => :right}
             ]]
    end

    if isGST(Date.parse(start_date))
      table(data, :column_widths => {0 => 25,1 => 40,2 => 55,3 => 95,4 => 115,5 => 35, 6 => 35, 7 => 35},
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})

    else
      table(data, :column_widths => {0 => 25,1 => 45,2 => 65,3 => 80,4 => 145,5 => 55, 6 => 55},
          :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})
    end



  end
end