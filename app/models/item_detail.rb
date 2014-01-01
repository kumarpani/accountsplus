class ItemDetail < ActiveRecord::Base
  belongs_to :quotation

  before_save :update_price

  validates_presence_of :particulars, :unit_price

  def update_price
    if self.days.nil?
      self.days = 1
    end
    if self.quantity.nil?
      self.quantity = 1
    end

    self.price = self.unit_price * self.quantity * self.days

  end

end
