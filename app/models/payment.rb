class Payment < ActiveRecord::Base
  belongs_to :client
  belongs_to :item_detail
end
