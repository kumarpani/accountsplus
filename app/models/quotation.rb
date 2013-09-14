class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details

  def total_price
    item_details.to_a.sum { |item| item.price }
  end
end
