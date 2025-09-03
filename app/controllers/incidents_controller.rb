class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[ show edit update destroy ]
  before_action :set_asset,    only: %i[index new create]

  def index
    @incidents = @asset ? @asset.incidents : Incident.includes(:asset)

    if params[:status].present?
      @incidents = @incidents.where(status: params[:status])
    end

    if params[:severity].present?
      @incidents = @incidents.where(severity: params[:severity])
    end

    if params[:started_from].present?
      @incidents = @incidents.where('started_at >= ?', params[:started_from])
    end

    if params[:started_to].present?
      @incidents = @incidents.where('started_at <= ?', params[:started_to])
    end

    if params[:q].present?
      @incidents = @incidents.where('cause ILIKE :q OR notes ILIKE :q', q: "%#{params[:q]}%")
    end

    @incidents = @incidents.order(started_at: :desc)
  end

  def new
    @incident = (@asset ? @asset.incidents.new : Incident.new)
  end

  def create
    @incident = (@asset ? @asset.incidents.new(incident_params) : Incident.new(incident_params))
    if @incident.save
      redirect_to @incident, notice: "Incident was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @incident.update(incident_params)
      redirect_to @incident, notice: "Incident was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @incident.destroy!
    redirect_to incidents_path, status: :see_other, notice: "Incident was successfully destroyed."
  end

  private
  def set_incident
    @incident = Incident.find(params[:id]) 
  end

  private
  def set_asset
    aid = params[:asset_id] || params.dig(:incident, :asset_id)
    @asset = Asset.find(aid) if aid.present?
  end

  def incident_params
    params.require(:incident).permit(
      :asset_id, :status, :severity, :started_at, :resolved_at, :cause, :notes
    )
  end
end
