class PrintQuotation < PrintBase

  include PrintQuotationsHelper
  include ApplicationHelper


  def initialize(id, unit_price=nil, bank=nil, seal=nil)
    super()
    q = Quotation.find(id)

    if q.invoice_raised_date.nil? || isGST(q.invoice_raised_date)
      logo_and_address_gst
      title_gst(get_header_for_print_quotation(q))
      quotation_details_gst(q)
      items_table_gst(q, unit_price)
    else
      logo_and_address
      title(get_header_for_print_quotation(q))
      quotation_details(q)

      if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        service_tax_details
      end

      items_table(q, unit_price)
    end


    if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
      price_in_rupees(q.total_price.to_i.rupees)
    else
      price_in_rupees(q.total_item_price.to_i.rupees)
    end

    if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        bank_details(bank, seal)
    end

    if !q.is_a_complete_tax_invoice?  and !q.is_a_complete_tax_exempted_invoice? and !q.tac.nil?
      terms_and_conditions(q)
    end
    if q.invoice_raised_date.nil? || !isGST(q.invoice_raised_date)

      signature(seal)
    end
  end

  def logo_and_address
    column_box([0, cursor], :columns => 2, :width=>470, :height => 72) do

      image "#{Rails.root}/app/assets/images/logo.jpg", height: 72

      text("#{ApplicationHelper::ADD_LINE1}", align: :right)
      text("#{ApplicationHelper::ADD_LINE2}", align: :right)
      text("#{ApplicationHelper::ADD_LINE3}", align: :right)
      text("Tele Fax: #{ApplicationHelper::TELEPHONE}", align: :right)
      text("Cell: #{ApplicationHelper::MOBILE}", align: :right)
      text("Email: #{ApplicationHelper::EMAIL}", align: :right)

    end

    stroke_horizontal_rule
  end

  def logo_and_address_gst
    column_box([0, cursor], :columns => 2, :width=>470, :height => 55) do

      image "#{Rails.root}/app/assets/images/logo.jpg", height: 55

      text("#{ApplicationHelper::ADD_LINE1}", align: :right)
      text("#{ApplicationHelper::ADD_LINE2}", align: :right)
      text("#{ApplicationHelper::ADD_LINE3}", align: :right)
      text("Ph : #{ApplicationHelper::TELEPHONE} Cell : #{ApplicationHelper::MOBILE}", align: :right)
      text("Email: #{ApplicationHelper::EMAIL}", align: :right)

    end
  end

  def title(title)
    draw_text title, size: 14, style: :bold_italic, :at => [180, 685]
  end

  def title_gst(title)

    myGstin = "GSTIN : #{ApplicationHelper::GSTIN} / State Code : #{ApplicationHelper::STATE_CODE}"
    data = [
              [{:content => title, :font_style => :bold, :align => :center, :background_color => 'ccffff'}],
              [{:content => myGstin, :align => :center, :background_color => 'ccffff'}]
    ]
    table(data, :column_widths => {0 => 470},
          :header => true,
          :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5, :align => :center})
  end

  def quotation_details(q)

    define_grid(:columns => 4, :rows => 15)
    #grid([2, 0], [1.9, 1]).show
    #grid([2, 3], [1.9, 2]).show

    grid([2, 0], [1.9, 1]).bounding_box do
      if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        text("Invoice No: #{q.invoice_number}")
      end
      text("To: #{q.client.company_name}", style: :bold)
      text(q.client.address)
    end

    grid([2, 3], [1.9, 2]).bounding_box do
      text("Date: #{get_display_date(q).to_date.strftime('%d/%m/%Y')}", align: :right)
      text("Event Date: #{q.event_date.strftime('%d/%m/%Y')}", align: :right)

      if !q.venue.blank?
        text("Venue: #{q.venue}", align: :right)
      end
      if !q.order_placed_by.blank?
        text("Order Placed By: #{q.order_placed_by}", align: :right)
      end
    end
  end

  def quotation_details_gst(q)

    define_grid(:columns => 4, :rows => 14)
     # grid([1.65, 0], [1.9, 1]).show
     # grid([1.57, 3], [1.9, 2.2]).show

    grid([1.65, 0], [1.9, 1]).bounding_box do
      text("To: #{q.client.company_name}", style: :bold)
      text(q.client.address)
      text(" ")
      text ("Client's GSTIN : #{q.client.gstin}")
    end

    grid([1.57, 3], [1.9, 2.2]).bounding_box do

      data = [[]]
      if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        data += [["Invoice No:", "#{q.invoice_number}".to_s[4..6]]]
      end
      event_dates = q.event_date.strftime('%d/%m/%Y')
      if not q.event_end_date.nil?
        event_dates += " to #{q.event_end_date.strftime('%d/%m/%Y')}"
      end

      if q.is_a_quotation?
        data += [["Quotation Date:", "#{get_display_date(q).to_date.strftime('%d/%m/%Y')}"]]
      else
        data += [["Invoice Date:", "#{get_display_date(q).to_date.strftime('%d/%m/%Y')}"]]
      end

      data += [["Event Date:", "#{event_dates}"]]

      if !q.venue.blank?
        data += [["Venue:", "#{q.venue}"]]
      end

      table(data, :column_widths => {0 => 70, 1=> 141},
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})
    end

  end


  def service_tax_details

    if ApplicationHelper::PAN_NUMBER != ''
      text "IT PAN No: #{ApplicationHelper::PAN_NUMBER}"
    end

    text "Service Tax Number: #{ApplicationHelper::SERVICE_TAX_NUMBER}"

    if ApplicationHelper::SERVICE_CATEGORY != ''
      text "Service Category: #{ApplicationHelper::SERVICE_CATEGORY}"
      text "\n"
    end
  end

  def get_item_table_header(unit_price)
    data =  [[
                {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                {:content => 'Particulars', :font_style => :bold, :align => :center},
                {:content => 'Quantity', :font_style => :bold, :align => :center},
                {:content => 'Days', :font_style => :bold, :align => :center},
             ]]
    if !unit_price.nil?
      data[0] += [{:content => 'Unit Price', :font_style => :bold, :align => :center}]
    end
    data[0] += [{:content => 'Price', :font_style => :bold, :align => :center}]
    data

  end

  def get_item_table_header_gst(unit_price)
    data =  [[
                 {:content => 'SN', :font_style => :bold, :align => :center, :background_color => 'ccffff'},
                 {:content => 'Description', :font_style => :bold, :align => :center, :background_color => 'ccffff'},
                 {:content => 'HSN/SAC', :font_style => :bold, :align => :center, :background_color => 'ccffff'},
                 {:content => 'Qty', :font_style => :bold, :align => :center, :background_color => 'ccffff'},
                 {:content => 'Days', :font_style => :bold, :align => :center, :background_color => 'ccffff'},
             ]]
    if !unit_price.nil?
      data[0] += [{:content => 'Unit Price', :font_style => :bold, :align => :center, :background_color => 'ccffff'}]
    end
    data[0] += [{:content => 'Amount', :font_style => :bold, :align => :center, :background_color => 'ccffff'}]
    data

  end


  def get_item_data(items, unit_price)
    data = [[]]
    items.sort_by {|s| s[:created_at]}.each_with_index do |item, index|
      data+=[[
                {:content => "#{index+1}", :align => :center},
                item.particulars,
                {:content => "#{item.quantity == 0 ? "" : item.quantity}", :align => :center},
                {:content => "#{item.days == 0 ? "" : item.days}", :align => :center},
            ]]
      if !unit_price.nil?
        data[index+1] += [{:content => "#{item.unit_price == 0 ? "" : ApplicationController.helpers.number_with_precision(item.unit_price, :precision =>2)}", :align => :right}]
      end
      data[index+1] += [{:content => "#{item.price == 0 ? "" : ApplicationController.helpers.number_with_precision(item.price, :precision =>2)}", :align => :right}]
    end
    data.delete_at(0)
    data
  end

  def get_item_data_gst(items, unit_price)
    data = [[]]
    items.sort_by {|s| s[:created_at]}.each_with_index do |item, index|
      sac = item.saccode
      if item.saccode == ""
        sac = "998596"
      end
      data+=[[
                 {:content => "#{index+1}", :align => :center},
                 item.particulars,
                 {:content => "#{sac}", :align => :center},
                 {:content => "#{item.quantity == 0 ? "" : item.quantity}", :align => :center},
                 {:content => "#{item.days == 0 ? "" : item.days}", :align => :center},
             ]]
      if !unit_price.nil?
        data[index+1] += [{:content => "#{item.unit_price == 0 ? "" : ApplicationController.helpers.number_with_precision(item.unit_price, :precision =>2)}", :align => :right}]
      end
      data[index+1] += [{:content => "#{item.price == 0 ? "" : ApplicationController.helpers.number_with_precision(item.price, :precision =>2)}", :align => :right}]
    end
    data.delete_at(0)
    data
  end


  def items_table(q, unit_price)
    data = get_item_table_header(unit_price)

    @item_groups = q.item_details.group_by { |g| g.item_group_name }
    @item_groups['Others:'] = @item_groups.delete('')

    @item_groups.each_with_index do |(item_group_name, items), index|

      if item_group_name != 'Others:'
        data += ([[{:content => "(#{(index+65).chr})", :font_style => :bold, :align => :center},
                   {:content =>"#{item_group_name}", :colspan =>5, :font_style => :bold}]])
        data += get_item_data(items, unit_price)
      end

      if item_group_name == 'Others:' && !items.nil?
        if @item_groups.size > 1
          data += ([[{:content => "(#{(@item_groups.count-1+65).chr})", :font_style => :bold, :align => :center},
                     {:content =>"Others:", :colspan =>5, :font_style => :bold}]])
        end
        data += get_item_data(items, unit_price)
      end
    end

    data += [["", {:content => "Total:", :font_style => :bold}, "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_item_price, :precision => 2)}", :font_style => :bold, :align => :right}]]
    if !unit_price.nil?
      data[data.size-1].insert(2, "")
    end

    if q.is_a_complete_tax_invoice? || q.is_a_complete_tax_exempted_invoice?
      data += [["", {:content => "Service Tax @ #{SERVICE_TAX_PERCENTAGE}%"}, "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.service_tax_to_display, :precision => 2)}", :align => :right}]]
      data += [["", {:content => "Total with taxes (rounded off):", :font_style => :bold}, "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_price, :precision => 2)}", :font_style => :bold, :align => :right}]]

      if !unit_price.nil?
        data[data.size-4].insert(2, "")
        data[data.size-3].insert(2, "")
        data[data.size-2].insert(2, "")
        data[data.size-1].insert(2, "")
      end

    end



    if unit_price.nil?
      table(data, :column_widths => {0 => 45,1 => 265,2 => 50,3 => 50,4 => 60},
            :header => true,
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})

    else
        table(data, :column_widths => {0 => 45,1 => 250,2 => 45,3 => 30,4 => 50, 5 => 50},
          :header => true,
          :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})
    end
  end


  def items_table_gst(q, unit_price)
    data = get_item_table_header_gst(unit_price)

    @item_groups = q.item_details.group_by { |g| g.item_group_name }
    @item_groups['Others:'] = @item_groups.delete('')

    @item_groups.each_with_index do |(item_group_name, items), index|

      if item_group_name != 'Others:'
        data += ([[{:content => "(#{(index+65).chr})", :font_style => :bold, :align => :center},
                   {:content =>"#{item_group_name}", :colspan =>5, :font_style => :bold}]])
        data += get_item_data_gst(items, unit_price)
      end

      if item_group_name == 'Others:' && !items.nil?
        if @item_groups.size > 1
          data += ([[{:content => "(#{(@item_groups.count-1+65).chr})", :font_style => :bold, :align => :center},
                     {:content =>"Others:", :colspan =>5, :font_style => :bold}]])
        end
        data += get_item_data_gst(items, unit_price)
      end
    end

    data += [["", {:content => "Total Value", :font_style => :bold}, "", "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_item_price, :precision => 2)}", :font_style => :bold, :align => :right}]]
    if !unit_price.nil?
      data[data.size-1].insert(2, "")
    end

    if q.is_a_complete_tax_invoice? || q.is_a_complete_tax_exempted_invoice?
      data += [["", {:content => "CGST Tax @ #{CGST_SERVICE_TAX_PERCENTAGE}%"}, "", "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.service_tax_to_display/2, :precision => 2)}", :align => :right}]]
      data += [["", {:content => "SGST Tax @ #{SGST_SERVICE_TAX_PERCENTAGE}%"}, "", "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.service_tax_to_display/2, :precision => 2)}", :align => :right}]]
      data += [["", {:content => "Total with taxes (rounded off):", :font_style => :bold}, "", "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_price, :precision => 2)}", :font_style => :bold, :align => :right}]]

      if !unit_price.nil?
        data[data.size-3].insert(2, "")
        data[data.size-2].insert(2, "")
        data[data.size-1].insert(2, "")
      end

    end

    if unit_price.nil?
      table(data, :column_widths => {0 => 25,1 => 280,2 => 45,3 => 30,4 => 30,5 => 60},
            :header => true,
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})

    else
      table(data, :column_widths => {0 => 25,1 => 230,2 => 45,3 => 30,4 => 30,5 => 50, 6 => 60},
            :header => true,
            :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})
    end
  end



  def price_in_rupees(price)
    text("\nRupees:#{price}", :align => :right)
  end

  def bank_details(nick_name, seal)

    if nick_name.nil?
      signature(seal)
      return;
    end

    b = ApplicationHelper::BANKS.find{|b| b.nick_name == nick_name}

    data =  [[
                 {:content => ' ', :font_style => :bold, :colspan => 3, :borders => []},

             ]]
    data +=  [[
                 {:content => 'Account Details for NEFT or RTGS : ', :font_style => :bold, :colspan => 2},
                 {:content => "For #{ApplicationHelper::NAME}", :borders => [:left], :align => :right},

             ]]
    data +=  [[
                 {:content => 'Account Name', :font_style => :bold},
                 {:content => b.account_name},
                 {:image => "#{Rails.root}/app/assets/images/sealandsign.jpg", :image_height => 70, :image_width => 70, :borders => [:left], :rowspan => 5, :position => :right},
             ]]
    data += [[

                 {:content => 'Name of the Bank & Branch', :font_style => :bold},
                 {:content => b.name + ' ,' + b.branch}
             ]]
    data += [[

                 {:content => 'Bank Account Number', :font_style => :bold},
                 {:content =>b.account_number}
             ]]
    data += [[

                 {:content => 'Type of Account', :font_style => :bold},
                 {:content => b.account_type}
             ]]
    data += [[

                 {:content => 'IFSC Code', :font_style => :bold},
                 {:content => b.ifsc}
             ]]

    if b.mirc != ''
      data += [[
                   {:content => 'MICR Code', :font_style => :bold},
                   {:content => b.mirc},
                   {:content => 'Authorized Signatory', :borders => [:left], :align => :right},
               ]]
    end

    table(data, :column_widths => {0 => 130,1=>150,2 => 190},
          :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 2.5})
  end

  def terms_and_conditions(q)
    data = [[]]
    if !q.custom_tac.nil?
      data += custom_terms_conditions(q)
    end
    q.tac.select{ |t| t != ''}.each do |t|
      data +=  [[
                   {:content => '•', :font_style => :bold},
                   {:content => "#{t}"}
               ]]
    end

    if (data.length > 2)
      text("\nTerms and Conditions\n", :style => :bold)
      table(data, :column_widths => {0 => 13,1 => 457},
            :cell_style => {:border_width => 0, :inline_format => true, :padding => 1})

    end
  end

  def custom_terms_conditions(q)
    data = [[]]
    q.custom_tac.split(/\r\n/).each do |t|
      data +=  [[
                    {:content => '•', :font_style => :bold},
                    {:content => "#{t}"}
                ]]
    end
    data
  end

  def signature(seal)
    text("\nFor #{ApplicationHelper::NAME}\n")
    if !seal.nil?
      image "#{Rails.root}/app/assets/images/sealandsign.jpg", height: 70
    else
      text("\n\n\n\n")
    end
    text("Authorized Signatory")

  end
end
