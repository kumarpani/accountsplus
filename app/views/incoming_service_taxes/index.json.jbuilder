json.array!(@incoming_service_taxes) do |incoming_service_tax|
  json.extract! incoming_service_tax, :invoice_number, :invoice_date, :description, :event_total, :service_tax
  json.url incoming_service_tax_url(incoming_service_tax, format: :json)
end
