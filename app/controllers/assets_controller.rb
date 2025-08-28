class AssetsController < ApplicationController
  before_action :set_asset, only: %i[ show edit update destroy ]

  def index
    @assets = Asset.all
  end

  def show
  end

  def new
    @asset = Asset.new
  end

  def edit
  end

  def create
    @asset = Asset.new(asset_params)

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: "Asset was successfully created." }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: "Asset was successfully updated." }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset.destroy!

    respond_to do |format|
      format.html { redirect_to assets_path, status: :see_other, notice: "Asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_asset
      @asset = Asset.find(params[:id])
    end
    
    def asset_params
      params.require(:asset).permit(:name, :category, :status, :latitude, :longitude, :metadata)
    end
end