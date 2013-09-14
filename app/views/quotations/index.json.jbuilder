json.array!(@quotations) do |quotation|
  json.extract! quotation, :client_id
  json.url quotation_url(quotation, format: :json)
end
