json.array!(@print_quotations) do |print_quotation|
  json.extract! print_quotation, 
  json.url print_quotation_url(print_quotation, format: :json)
end
