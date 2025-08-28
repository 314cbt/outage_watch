json.extract! work_order, :id, :asset_id, :title, :description, :scheduled_for, :status, :created_at, :updated_at
json.url work_order_url(work_order, format: :json)
