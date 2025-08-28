class MapController < ApplicationController
  def show
    @assets = Asset.select(:id, :name, :latitude, :longitude, :status, :category)
  end
end 
