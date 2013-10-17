class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details, :dependent => :delete_all
  accepts_nested_attributes_for :item_details, :allow_destroy => true, :reject_if => :client_is_unknown

  serialize :tac

  def total_price
    item_details.to_a.sum(&:price)
  end

  def start_time
    event_date.to_datetime
  end
end
