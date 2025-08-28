# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Wipe in dependency order
IncidentEvent.destroy_all
Incident.destroy_all
WorkOrder.destroy_all
Asset.destroy_all
User.destroy_all

# User to log in
User.create!(email: "admin@example.com", password: "password")

# Assets first
a1 = Asset.create!(
  name: "Substation A", category: "substation", status: "active",
  latitude: 33.5207, longitude: -86.8025, metadata: { kv: 115 }
)

a2 = Asset.create!(
  name: "Feeder F-12", category: "feeder", status: "active",
  latitude: 33.51, longitude: -86.78, metadata: { length_mi: 12 }
)

# Incident tied to an asset
i1 = Incident.create!(
  asset: a2, status: "open", severity: "major",
  started_at: Time.current, cause: "storm", notes: "Lines down near main rd"
)

# Timeline event on that incident
IncidentEvent.create!(
  incident: i1, kind: "created", occurred_at: Time.current, message: "Incident opened"
)

# Work order tied to an asset
WorkOrder.create!(
  asset: a2, title: "Replace crossarm", description: "Wood split",
  scheduled_for: 2.days.from_now, status: "planned"
)

puts "Seeded: #{Asset.count} assets, #{Incident.count} incidents, #{IncidentEvent.count} events, #{WorkOrder.count} work orders, #{User.count} user"

