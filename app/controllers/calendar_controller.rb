class CalendarController < ApplicationController
  def index
    valid_quotations = Quotation.where.not(status: STATUS_CLOSED)
    @all_quotations = Array.new
    valid_quotations.each { |quotation|
      quotation.days = quotation.days || 1;
      quotation.days.times do |i|
        q = Marshal.load(Marshal.dump(quotation))
        q.event_date = q.event_date.to_date + i;
        @all_quotations.push q
      end
    }
  end
end
