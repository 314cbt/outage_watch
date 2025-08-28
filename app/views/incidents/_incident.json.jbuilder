json.extract! incident, :id, :asset_id, :status, :severity, :started_at, :resolved_at, :cause, :notes, :created_at, :updated_at
json.url incident_url(incident, format: :json)
