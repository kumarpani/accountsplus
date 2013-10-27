class ItemDetail < ActiveRecord::Base
  belongs_to :quotation
  belongs_to :vendor, foreign_key: 'vendor_id', class_name: 'Client'

  validates_presence_of :particulars, :price

end
