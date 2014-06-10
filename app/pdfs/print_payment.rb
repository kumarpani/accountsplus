class PrintPayment < PrintBase

 def initialize(payment_id, email)
    super()

    payment = Payment.find(payment_id)
    logo_and_address
    header(payment)

    if payment.payment_type =='Debit'
      receipt(payment, email)
    end

    else if payment.payment_type =='Credit'
        cash_voucher(payment, email)
         end

  # signature
 end


 def logo_and_address
   column_box([0, cursor], :columns => 2, :width=>470, :height => 60) do

     image "#{Rails.root}/app/assets/images/logo.jpg", height: 60

     text("#{ApplicationHelper::ADD_LINE1}", align: :right)
     text("#{ApplicationHelper::ADD_LINE2}", align: :right)
     text("#{ApplicationHelper::ADD_LINE3}", align: :right)
     text("Tele Fax: #{ApplicationHelper::TELEPHONE}", align: :right)
     text("Email: #{ApplicationHelper::EMAIL}", align: :right)

   end

   stroke_horizontal_rule


 end

 def header(payment)
   text("\n")
   text("\n")
   if payment.payment_type =='Debit'
     text("RECEIPT", :font_style => :bold, :size => 15, :align => :center)
   end

 else if payment.payment_type =='Credit'
        text("CASH VOUCHER", :font_style => :bold, :size => 15, :align => :center)
      end

 end

  def cash_voucher(payment, email)
    text ("\n")
    data =  [
                 [{:content => 'Date:', :font_style => :bold},        {:content => payment.paid_on.strftime("%d/%m/%Y"), :font_style => :italic}],
                 [{:content => 'Pay to:', :font_style => :bold},      {:content => payment.client.company_name, :font_style => :italic}],
                 [{:content => 'Received by:', :font_style => :bold},      {:content => payment.paid_to, :font_style => :italic}],
                 [{:content => 'Rupees:', :font_style => :bold},      {:content => payment.amount.to_s + ' (Rupees: ' + payment.amount.to_i.rupees + ')', :font_style => :italic}],
                 [{:content => 'By:', :font_style => :bold},          {:content => payment.mode, :font_style => :italic}],
                 [{:content => 'Being:', :font_style => :bold},       {:content => payment.description, :font_style => :italic}],
                 [{:content => 'Prepared by:', :font_style => :bold}, {:content => email, :font_style => :italic, :align => :left}],
                 [{:content => ''}, {:content => 'Receiver\'s Signature', :font_style => :bold, :align => :right}],
             ]

    table(data, :column_widths => {0 => 120, 1=> 350},
          :cell_style => {:border_width => 0, :inline_format => true, :padding => 3, :size => 10})

  end

 def receipt(payment, email)
   text ("\n")
   data =  [
       [{:content => 'Date:', :font_style => :bold},        {:content => payment.paid_on.strftime("%d/%m/%Y"), :font_style => :italic}],
       [{:content => 'Received with thanks from:', :font_style => :bold},      {:content => payment.client.company_name, :font_style => :italic}],
       [{:content => 'Received by:', :font_style => :bold},      {:content => payment.paid_to, :font_style => :italic}],
       [{:content => 'A sum of Rupees:', :font_style => :bold},      {:content => payment.amount.to_s + ' (Rupees: ' + payment.amount.to_i.rupees + ')', :font_style => :italic}],
       [{:content => 'Towards:', :font_style => :bold},          {:content => payment.description, :font_style => :italic}],
       [{:content => 'By:', :font_style => :bold},       {:content => payment.mode, :font_style => :italic}],
       [{:content => 'Prepared by:', :font_style => :bold}, {:content => email, :font_style => :italic, :align => :left}],
       [{:content => ''}, {:content => 'Receiver\'s Signature', :font_style => :bold, :align => :right}],
   ]

   table(data, :column_widths => {0 => 170, 1=> 300},
         :cell_style => {:border_width => 0, :inline_format => true, :padding => 3, :size => 10})

 end

 def signature
   text("\nFor #{ApplicationHelper::NAME}\n\n\n\n", :align => :right)
   text("Authorized Signature", :align => :right)

 end
end                                     