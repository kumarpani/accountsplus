class Client < ActiveRecord::Base
  has_many :quotations, :dependent => :delete_all
  has_many :payments, :dependent => :delete_all

  validates_presence_of :company_name, :contact_person_name
end
