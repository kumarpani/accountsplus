class ActivityController < ApplicationController
  def index
    if !params[:start_date].to_s.empty? && !params[:end_date].to_s.empty?
      @s_date = Date.parse(params[:start_date], '%d/%m/%Y')
      @e_date = Date.parse(params[:end_date], '%d/%m/%Y')
    else
      @s_date = Date.yesterday
      @e_date = Date.tomorrow
    end

    @invoices_raised = Quotation.where('invoice_raised_date >= ? AND invoice_raised_date <= ?', @s_date, @e_date).order(:invoice_raised_date).reverse_order

    @payments_changed = Payment.where('created_at >= ? AND created_at <= ?', @s_date, @e_date)
    @payments_changed += Payment.where('updated_at >= ? AND updated_at <= ?', @s_date, @e_date).where('created_at != updated_at')
    @payments_changed = @payments_changed.sort_by {|p| p[:updated_at]}.reverse

    @quotations_changed = Quotation.where('created_at >= ? AND created_at <= ?', @s_date, @e_date)
    @quotations_changed += Quotation.where('updated_at >= ? AND updated_at <= ?', @s_date, @e_date).where('created_at != updated_at')
    @quotations_changed = @quotations_changed.select{|q| q.status != STATUS_INVOICE}.sort_by {|p| p[:updated_at]}.reverse

  end

end
