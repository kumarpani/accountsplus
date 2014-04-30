class PrintQuotation < PrintBase

  include PrintQuotationsHelper

  def initialize(id, bank=nil)
    super()
    q = Quotation.find(id)
    logo_and_address()
    title(get_header_for_print_quotation(q))
    quotation_details(q)
    if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
      service_tax_details
    end
    items_table(q)
    price_in_rupees(q.total_price.to_i.rupees)
    if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
      if bank
        bank_details
      end
    end
    if !q.is_a_complete_tax_invoice?  and !q.is_a_complete_tax_exempted_invoice? and !q.tac.nil?
      terms_and_conditions(q)
    end
    signature
  end

  def logo_and_address
    column_box([0, cursor], :columns => 2, :width=>450, :height => 72) do

      image "#{Rails.root}/app/assets/images/ap.jpg", height: 72

      text("#{ApplicationHelper::ADD_LINE1}", align: :right)
      text("#{ApplicationHelper::ADD_LINE2}", align: :right)
      text("#{ApplicationHelper::ADD_LINE3}", align: :right)
      text("Tele Fax: #{ApplicationHelper::TELEPHONE}", align: :right)
      text("Cell: #{ApplicationHelper::MOBILE}", align: :right)
      text("Email: #{ApplicationHelper::EMAIL}", align: :right)

    end

    text "\n"
    stroke_horizontal_rule
  end

  def title(title)
    draw_text title, size: 14, style: :bold_italic, :at => [170, 670]
  end

  def quotation_details(q)

    define_grid(:columns => 4, :rows => 8, :gutter => 35)
    #grid([1.2, 0], [1.2, 0.7]).show
    #grid([1.2, 3], [1.2, 2]).show

    grid([1.2,0], [1.2, 0.7]).bounding_box do
      if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        text("Invoice No: #{q.invoice_number}")
      end
      text("To: #{q.client.company_name}", style: :bold)
      text(q.client.address)
    end

    grid([1.2, 3], [1.2, 2]).bounding_box do
      text("Date: #{get_display_date(q).to_date.strftime('%d/%m/%Y')}", align: :right)
      text("Event Date: #{q.event_date.strftime('%d/%m/%Y')}", align: :right)

      if !q.venue.nil?
        text("Venue: #{q.venue}", align: :right)
      end
      if !q.order_placed_by.nil?
        text("Order Placed By: #{q.order_placed_by}", align: :right)
      end
    end
  end

  def service_tax_details
    text "Service Tax Number: #{ApplicationHelper::SERVICE_TAX_NUMBER}"
    text "\n"
  end

  def items_table(q)
    data =  [[
                 {:content => 'Sl. No.', :font_style => :bold, :align => :center},
                 {:content => 'Particulars', :font_style => :bold, :align => :center},
                 {:content => 'Quantity', :font_style => :bold, :align => :center},
                 {:content => 'Days', :font_style => :bold, :align => :center},
                 {:content => 'Price', :font_style => :bold, :align => :center}
             ]]

    @item_groups = q.item_details.group_by { |g| g.item_group_name }
    @item_groups['Others:'] = @item_groups.delete('')

    @item_groups.each_with_index do |(item_group_name, items), index|

      if item_group_name != 'Others:'
        data += ([[{:content => "(#{(index+65).chr})", :font_style => :bold, :align => :center},
                   {:content =>"#{item_group_name}", :colspan =>5, :font_style => :bold}]])
        items.sort_by {|s| s[:created_at]}.each_with_index do |item, index|
          data+=[[{:content => "#{index+1}", :align => :center},
                  item.particulars,
                  {:content => "#{item.quantity}", :align => :center},
                  {:content => "#{item.days}", :align => :center},
                  {:content => "#{item.price == 0 ? "" : item.price}", :align => :right}]]
        end
      end

      if item_group_name == 'Others:'
        if @item_groups.size > 1
          data += ([[{:content => "(#{(index+65).chr})", :font_style => :bold, :align => :center},
                     {:content =>"Others:", :colspan =>5, :font_style => :bold}]])
        end

        @item_groups['Others:'].sort_by {|s| s[:created_at]}.each_with_index do |item, index|
          data+=[[{:content => "#{index+1}", :align => :center},
                  item.particulars,
                  {:content => "#{item.quantity}", :align => :center},
                  {:content => "#{item.days}", :align => :center},
                  {:content => "#{item.price == 0 ? "" : item.price}", :align => :right}]]
        end
      end
    end

    data += [["", {:content => "Total:", :font_style => :bold}, "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_item_price, :precision => 2)}", :font_style => :bold, :align => :right}]]

    if q.is_a_complete_tax_invoice? || q.is_a_complete_tax_exempted_invoice?
      data += [["", "Service Tax @ 12%", "", "", {:content => "#{q.service_tax_at_12_percent}", :align => :right}]]
      data += [["", "Education Cess @ 2% (On S.T)", "", "", {:content => "#{q.education_cess}", :align => :right}]]
      data += [["", "Secondary & Higher Education Cess @ 1% (On S.T)", "", "", {:content => "#{q.higher_education_cess}", :align => :right}]]
      data += [["", {:content => "Total with taxes (rounded off):", :font_style => :bold}, "", "", {:content => "#{ApplicationController.helpers.number_with_precision(q.total_price, :precision => 2)}", :font_style => :bold, :align => :right}]]
    end


    table(data, :column_widths => {0 => 40,1 => 250,2 => 50,3 => 50,4 => 60},
          :header => true,
          :cell_style => {:border_width => 0.2, :border_color => 'bdc3c7', :height => 18})

  end

  def price_in_rupees(price)
    text("\nRupees:#{price}", :align => :right)
  end

  def bank_details

    text("\nAccount Details for NEFT or RTGS\n", :style => :bold)
    data =  [[
                 {:content => 'Account Name', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_ACC_NAME}"}
             ]]
    data += [[
                 {:content => 'Name of the Bank & Branch', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_NAME_BRANCH}"}
             ]]
    data += [[
                 {:content => 'Bank Account Number', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_ACC_NUM}"}
             ]]
    data += [[
                 {:content => 'Type of Account', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_TYPE_OF_ACC}"}
             ]]
    data += [[
                 {:content => 'IFSC Code', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_IFSC}"}
             ]]

    data += [[
                 {:content => 'MICR Code', :font_style => :bold},
                 {:content => "#{ApplicationHelper::BANK_MIRC}"}
             ]]
    table(data, :column_widths => {0 => 225,1 => 225},
          :cell_style => {:border_width => 0.2, :border_color => 'bdc3c7', :height => 18})
  end

  def terms_and_conditions(q)
    text("\nTerms and Conditions\n", :style => :bold)

    q.tac.each do |t|
      text("#{t}")
    end
  end

  def signature
    text("\nFor #{ApplicationHelper::NAME}\n\n\n\n")
    text("Authorized Signatory")

  end

end