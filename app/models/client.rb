class Client < ActiveRecord::Base
  has_many :quotations
  has_many :payments
end
