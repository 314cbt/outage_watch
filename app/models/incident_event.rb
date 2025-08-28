class IncidentEvent < ApplicationRecord
  belongs_to :incident
  after_create_commit -> { broadcast_append_to [incident, :events] }
end
