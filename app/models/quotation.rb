class Quotation < ActiveRecord::Base
  belongs_to :client
  has_many :item_details
end
