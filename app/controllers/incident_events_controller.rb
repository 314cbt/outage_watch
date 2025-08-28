class IncidentEventsController < ApplicationController
  before_action :set_incident_event, only: %i[ show edit update destroy ]

  def index
    @incident_events = IncidentEvent.all
  end

  def show
  end

  def new
    @incident_event = IncidentEvent.new
  end

  def edit
  end

  def create
    @incident_event = IncidentEvent.new(incident_event_params)

    respond_to do |format|
      if @incident_event.save
        format.html { redirect_to @incident_event, notice: "Incident event was successfully created." }
        format.json { render :show, status: :created, location: @incident_event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @incident_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @incident_event.update(incident_event_params)
        format.html { redirect_to @incident_event, notice: "Incident event was successfully updated." }
        format.json { render :show, status: :ok, location: @incident_event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @incident_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @incident_event.destroy!

    respond_to do |format|
      format.html { redirect_to incident_events_path, status: :see_other, notice: "Incident event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_incident_event
      @incident_event = IncidentEvent.find(params[:id])
    end

    def incident_event_params
      params.require(:incident_event).permit(:incident_id, :kind, :occurred_at, :message)
    end
end
