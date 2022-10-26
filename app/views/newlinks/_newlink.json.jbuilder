json.extract! newlink, :id, :url, :slug, :created_at, :updated_at
json.url newlink_url(newlink, format: :json)
