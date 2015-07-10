class Payment < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :client_id, :mode, :paid_on, :amount, :payment_type

  def filter(s_date, e_date)
    if !s_date.to_s.empty? && !e_date.to_s.empty?
      @s_date = Date.parse(s_date, '%d/%m/%Y')
      @e_date = Date.parse(e_date, '%d/%m/%Y')

      Payment.where('paid_on >= ? AND paid_on <= ?', @s_date, @e_date).order(:paid_on).reverse_order
    end
  end
end
