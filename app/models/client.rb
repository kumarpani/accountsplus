class Client < ActiveRecord::Base
  acts_as_xlsx

  has_many :quotations, :dependent => :delete_all
  has_many :payments, :dependent => :delete_all
  has_many :incoming_service_taxes, :dependent => :delete_all

  validates_presence_of :company_name, :contact_person_name

  def self.search(search)
    if search
      find(:all, :conditions => ['company_name ILIKE ? OR contact_person_name ILIKE ? OR email ILIKE ? OR phone_number ILIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    end
  end
end
