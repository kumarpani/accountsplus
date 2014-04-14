class ItemDetail < ActiveRecord::Base
  belongs_to :quotation

  before_save :update_price

  validates_presence_of :particulars

  def update_price
    days_final =  1
    if !self.days.nil?
      days_final = self.days
    end

    quantity_final = 1
    if !self.quantity.nil?
      quantity_final = self.quantity
    end

    unit_price_final = 1
    if !self.unit_price.nil?
      unit_price_final = self.unit_price
    end

    self.price = unit_price_final * quantity_final * days_final

  end

end
