json.extract! asset, :id, :name, :category, :status, :latitude, :longitude, :metadata, :created_at, :updated_at
json.url asset_url(asset, format: :json)
