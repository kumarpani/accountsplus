json.array!(@quotations) do |quotation|
  json.extract! quotation, :client_id, :name, :status
  json.url quotation_url(quotation, format: :json)
end
