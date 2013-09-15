class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details

  def total_price
    item_details.to_a.sum { |item| item.net_price }
  end

  def start_time
    event_date.to_datetime
  end
end
