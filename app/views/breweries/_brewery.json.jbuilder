json.extract! brewery, :id, :name, :year, :created_at, :updated_at, :active
json.beers brewery.beers.count
json.url brewery_url(brewery, format: :json)
