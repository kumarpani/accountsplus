json.array!(@item_details) do |item_detail|
  json.extract! item_detail, :name, :description, :price, :decimal
  json.url item_detail_url(item_detail, format: :json)
end
