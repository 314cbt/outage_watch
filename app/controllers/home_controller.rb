class HomeController < ApplicationController
  def index
    @assets_count      = Asset.count
    @incidents_count   = Incident.count
    @work_orders_count = WorkOrder.count
    @recent_incidents   = Incident.order(updated_at: :desc).limit(5)
    @recent_work_orders = WorkOrder.order(updated_at: :desc).limit(5)
    @recent_assets      = Asset.order(updated_at: :desc).limit(5)
  end
end
