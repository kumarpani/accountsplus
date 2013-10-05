class ItemDetail < ActiveRecord::Base
  belongs_to :quotation
  has_one :payment, :dependent => :delete
  accepts_nested_attributes_for :payment, :allow_destroy => true, :reject_if => :client_is_unknown

  def client_is_unknown(attributes)
    attributes['client_id'].blank?
  end
end
