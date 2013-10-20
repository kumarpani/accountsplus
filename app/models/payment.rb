class Payment < ActiveRecord::Base
  belongs_to :client
  belongs_to :item_detail

  validates_presence_of :paid_on, :amount

end
