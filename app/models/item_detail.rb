class ItemDetail < ActiveRecord::Base
  belongs_to :quotation

  before_save :update_price

  validates_presence_of :particulars

  def update_price
    if self.days.nil?
      self.days = 1
    end

    if self.quantity.nil?
      self.quantity = 1
    end

    unit_price_final = 0
    if !self.unit_price.nil?
      unit_price_final = self.unit_price
    end

    self.price = unit_price_final *
                (self.quantity != 0 ? self.quantity : 1) *
                (self.days != 0 ? self.quantity : 1)

  end

end
