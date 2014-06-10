class PrintPayment < PrintBase

 def initialize(payment_id, first_name, last_name)
    super()

    payment = Payment.find(payment_id)
    logo_and_address
    header(payment)

    if payment.payment_type =='Debit'
      receipt(payment)
    end

    else if payment.payment_type =='Credit'
        cash_voucher(payment, first_name, last_name)
         end

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

  def cash_voucher(payment, first_name, last_name)
    text ("\n")
    data =  [
                 [{:content => 'Date:', :font_style => :bold},        {:content => payment.paid_on.strftime("%d/%m/%Y"), :font_style => :italic}],
                 [{:content => 'Paid to:', :font_style => :bold},      {:content => get_received_by(payment.received_by, payment.client.company_name), :font_style => :italic}],
                 [{:content => 'Rupees:', :font_style => :bold},      {:content => payment.amount.to_s + ' (Rupees: ' + payment.amount.to_i.rupees + ')', :font_style => :italic}],
                 [{:content => 'By:', :font_style => :bold},          {:content => payment.mode, :font_style => :italic}],
                 [{:content => 'Being:', :font_style => :bold},       {:content => payment.description, :font_style => :italic}],
                 [{:content => 'Prepared by:', :font_style => :bold}, {:content => 'Receiver\'s Signature', :font_style => :bold, :align => :center}],
                 [{:content => "#{first_name} #{last_name}", :font_style => :italic}, {:content => ''}],
             ]

    table(data, :column_widths => {0 => 120, 1=> 350},
          :cell_style => {:border_width => 0, :inline_format => true, :padding => 3, :size => 10})

  end

 def receipt(payment)
   text ("\n")
   data =  [
       [{:content => 'Date:', :font_style => :bold},        {:content => payment.paid_on.strftime("%d/%m/%Y"), :font_style => :italic}],
       [{:content => 'Received with thanks from:', :font_style => :bold},      {:content => payment.client.company_name, :font_style => :italic}],
       [{:content => 'A sum of Rupees:', :font_style => :bold},      {:content => payment.amount.to_s + ' (Rupees: ' + payment.amount.to_i.rupees + ')', :font_style => :italic}],
       [{:content => 'Towards:', :font_style => :bold},          {:content => payment.description, :font_style => :italic}],
       [{:content => 'By:', :font_style => :bold},       {:content => payment.mode, :font_style => :italic}],
       [{:content => ''}, {:content => "For #{ApplicationHelper::NAME}", :font_style => :bold, :align => :center}],
   ]

   table(data, :column_widths => {0 => 170, 1=> 300},
         :cell_style => {:border_width => 0, :inline_format => true, :padding => 3, :size => 10})

 end

  def get_received_by(received_by, company_name)
    if received_by.nil? || received_by == ''
      company_name
    else
      received_by + ' from ' + company_name
    end
  end

end