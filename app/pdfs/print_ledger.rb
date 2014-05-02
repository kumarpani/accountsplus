class PrintLedger < PrintBase

  include ApplicationHelper

  def initialize(start_date, end_date, client_id, company_name)
    super()
    ledger = Ledger.new.index(start_date, end_date, client_id)

    header(company_name, start_date, end_date)
    ledger_table(ledger)

  end

  def header(company_name, start_date, end_date)
    if !start_date.blank? && !end_date.blank?
      text("Ledger of: #{company_name} between #{display_verbose_date(start_date)} and #{display_verbose_date(end_date)}", :style => :bold)
      text("\n")
    end


  end

  def ledger_table(ledger)
    data =  [[
                 {:content => 'Date', :font_style => :bold, :align => :center},
                 {:content => 'Description of Transaction', :font_style => :bold, :align => :center},
                 {:content => 'Debit', :font_style => :bold, :align => :center},
                 {:content => 'Credit', :font_style => :bold, :align => :center},
                 {:content => 'Balance', :font_style => :bold, :align => :center},
             ]]

    ledger.each_with_index do |l, index|

        data += ([[{:content => "#{display_date(l[:date].to_date)}", :align => :center},
                   {:content =>"#{l[:description]}", :align => :left},
                   {:content =>"#{l[:debit]}", :align => :right},
                   {:content => "#{l[:credit]}", :align => :right},
                   {:content =>"#{l[:balance]}", :align => :right},
                  ]])
    end

    table(data, :column_widths => {0 => 60,1 => 180,2 => 50,3 => 50, 4 => 50},
        :cell_style => {:border_width => 0.2, :border_color => '7f8c8d', :inline_format => true, :padding => 3})

  end
end