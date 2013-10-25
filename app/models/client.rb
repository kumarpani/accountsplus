class Client < ActiveRecord::Base
  has_many :quotations, :dependent => :delete_all
  has_many :payments, :dependent => :delete_all

  validates_presence_of :company_name, :contact_person_name

  def self.search(search)
    if search
      find(:all, :conditions => ['company_name LIKE ? OR contact_person_name LIKE ? OR email LIKE ? OR phone_number LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    end
  end
end
