json.extract! catalog, :id, :user_id, :entry_id, :system_id, :system_esi, :planet_id, :planet_esi, :moon_id, :moon_esi, :product_id, :product, :percent, :status, :verified, :flag, :created_at, :updated_at
json.url catalog_url(catalog, format: :json)
