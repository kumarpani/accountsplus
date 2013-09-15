json.array!(@quotations) do |quotation|
  json.extract! quotation, :client_id, :name, :status, :event_date
  json.url quotation_url(quotation, format: :json)
end
