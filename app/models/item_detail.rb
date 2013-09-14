class ItemDetail < ActiveRecord::Base
  belongs_to :quotation
  def net_price
    price * quantity
  end
end
