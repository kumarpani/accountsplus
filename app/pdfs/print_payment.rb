class PrintPayment < PrintBase

 def initialize(payment_type)
    super()
    logo_and_address
    header(payment_type)

    if payment_type =='Debit'
      receipt
    end

    else if payment_type =='Credit'
        cash_voucher
         end

  signature
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

 def header(payment_type)
   text("\n")
   text("\n")
   if payment_type =='Debit'
     text("RECEIPT", :font_style => :bold, :size => 18, :align => :center)
   end

 else if payment_type =='Credit'
        text("CASH VOUCHER", :font_style => :bold, :size => 18, :align => :center)
      end

 end

  def cash_voucher()
    text ("\n")
    data =  [
                 [{:content => '   '},'   ',{:content => 'Date:', :font_style => :bold, :align => :right},'   '],
                 [{:content => 'Pay to', :font_style => :bold, :align => :left},{:content => '   '}],
                 [{:content => 'Rupees', :font_style => :bold, :align => :left},{:content => '   '}],
                 [{:content => 'By Cash/Cheque', :font_style => :bold, :align => :left},'  ',{:content => 'Dated', :font_style => :bold, :align => :left},'  '],
                 [{:content => 'Being', :font_style => :bold, :align => :left},{:content => '   '}],
                 [{:content => 'and Debit', :font_style => :bold, :align => :left},{:content => '   '}],
                 [{:content => 'Prepared by', :font_style => :bold, :align => :left},{:content => 'Recd.Above Sum of Rs',:font_style => :bold, :align => :center},'   '],
             ]

    table(data, :column_widths => {0=>100,1=>250,2=>50,3=>50},
          :cell_style => {:border_width => 0, :height => 25, :inline_format => true, :padding => 3})

  end

 def receipt()
   text ("\n")
   data =  [
       [{:content => '   '},{:content => 'Date:', :font_style => :bold, :align => :right}],
       [{:content => 'Received with thanks from', :font_style => :bold, :align => :left},{:content => '   '}],
       [{:content => 'a sum of Rupees', :font_style => :bold, :align => :left},{:content => '   '}],
       [{:content => 'towards Hiring/Others', :font_style => :bold, :align => :left},'   '],
       [{:content => 'by Cash/Cheque/D.D', :font_style => :bold, :align => :left},{:content => '   '}],
       [{:content => 'drawn on', :font_style => :bold, :align => :left},{:content => '   '}],
       [{:content => 'Rs.____________', :font_style => :bold, :size => 12, :align => :left},{:content => 'Subject to realisation', :font_style => :bold, :align => :left}]
   ]

   table(data, :column_widths => {0=>150,1=>300},
         :cell_style => {:border_width => 0, :height => 25, :inline_format => true, :padding => 3})

 end

 def signature
   text("\nFor #{ApplicationHelper::NAME}\n\n\n\n", :align => :right)
   text("Authorized Signature", :align => :right)

 end
end                                     