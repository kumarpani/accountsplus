json.array!(@payments) do |payment|
  json.extract! payment, :client_id, :description, :mode, :paid_on, :amount
  json.url payment_url(payment, format: :json)
end
