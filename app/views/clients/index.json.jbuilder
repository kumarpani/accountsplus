json.array!(@clients) do |client|
  json.extract! client, :company_name, :address, :phone_number, :email
  json.url client_url(client, format: :json)
end
