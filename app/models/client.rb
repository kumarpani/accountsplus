class Client < ActiveRecord::Base
  has_many :quotations, :dependent => :delete_all
  has_many :payments, :dependent => :delete_all
end
