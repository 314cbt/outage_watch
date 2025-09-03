class HomeController < ApplicationController
  def index
    @assets_count       = Asset.count
    @incidents_count    = Incident.count
    @work_orders_count  = WorkOrder.count
    @recent_incidents   = Incident.order(updated_at: :desc).limit(5)
    @recent_work_orders = WorkOrder.order(updated_at: :desc).limit(5)
    @recent_assets      = Asset.order(updated_at: :desc).limit(5)
    @assets = Asset
      .where.not(latitude: nil, longitude: nil)
      .select(:id, :name, :latitude, :longitude, :status, :category)
  end
end
