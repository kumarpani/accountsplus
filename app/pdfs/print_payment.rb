class PrintPayment < PrintBase

 def initialize(payment_id, email)
    super()

    payment = Payment.find(payment_id)
    @user = User.current_user
    logo_and_address
    text(@user)
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
                 [{:content => 'Date: ' + payment.paid_on.strftime("%d/%m/%Y"), :font_style => :bold, :align => :right}],
                 [{:content => 'Pay to: ' + payment.client.company_name, :font_style => :bold, :align => :left}],
                 [{:content => 'Rupees: ' + payment.amount.to_s, :font_style => :bold, :align => :left}],
                 [{:content => 'By: ' + payment.mode, :font_style => :bold, :align => :left}],
                 [{:content => 'Being: ' + payment.description, :font_style => :bold, :align => :left}],
                 [{:content => 'Prepared by: ' + email, :font_style => :bold, :align => :left}],
             ]

    table(data, :column_widths => {0 => 450},
          :cell_style => {:border_width => 0, :height => 25, :inline_format => true, :padding => 3})

  end

 def receipt(payment, email)
   text ("\n")
   data =  [
       [{:content => 'Date: '+ payment.paid_on.strftime("%d/%m/%Y"), :font_style => :bold, :align => :right}],
       [{:content => 'Received with thanks from: ' + payment.client.company_name, :font_style => :bold, :align => :left}],
       [{:content => 'a sum of Rupees: ' + payment.amount.to_s(), :font_style => :bold, :align => :left}],
       [{:content => 'towards: ' + payment.description, :font_style => :bold, :align => :left}],
       [{:content => 'by: ' + payment.mode, :font_style => :bold, :align => :left}],
       [{:content => 'Prepared by: ' + email, :font_style => :bold, :align => :left}]
   ]

   table(data, :column_widths => {0 => 450},
         :cell_style => {:border_width => 0, :height => 25, :inline_format => true, :padding => 3})

 end

 def signature
   text("\nFor #{ApplicationHelper::NAME}\n\n\n\n", :align => :right)
   text("Authorized Signature", :align => :right)

 end
end                                     