json.extract! incident_event, :id, :incident_id, :kind, :occurred_at, :message, :created_at, :updated_at
json.url incident_event_url(incident_event, format: :json)
