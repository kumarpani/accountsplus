class Payment < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :client_id, :mode, :paid_on, :amount, :payment_type
end
