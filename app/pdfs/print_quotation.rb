class PrintQuotation < PrintBase

  include PrintQuotationsHelper

  TABLE_WIDTHS = [20, 100, 30, 60]
  TABLE_HEADERS = ["ID", "Name", "Date", "User"]



  def initialize(id)
    super()
    q = Quotation.find(id)
    logo_and_address()
    title(get_header_for_print_quotation(q))
    quotation_details(q)
    display_event_table
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
    draw_text title, size: 14, style: :bold_italic, :at => [160, 670]
  end

  def quotation_details(q)

    define_grid(:columns => 4, :rows => 8, :gutter => 20)
    #grid([1.2, 0], [1.2,0.2]).show
    #grid([1.2, 2.83], [1.2,1.5]).show

    grid([1.2,0], [1.2,0.2]).bounding_box do
      if q.is_a_complete_tax_invoice?  or q.is_a_complete_tax_exempted_invoice?
        text("Invoice No: #{q.invoice_number}")
      end
      text("To: #{q.client.company_name}", style: :bold)
      text(q.client.address)
    end

    grid([1.2, 2.83], [1.2,1.5]).bounding_box do
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

  def display_event_table
      text "\nPlease work #{ApplicationHelper::ADD_LINE1}"
  end


end