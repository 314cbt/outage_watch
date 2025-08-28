class WorkOrdersController < ApplicationController
  before_action :set_work_order, only: %i[show edit update destroy]
  before_action :set_asset, only: %i[index new create]

  def index
    @work_orders =
    if @asset
      @asset.work_orders
            .order(Arel.sql("CASE priority
                                WHEN 'urgent' THEN 1
                                WHEN 'high'   THEN 2
                                WHEN 'normal' THEN 3
                                WHEN 'low'    THEN 4
                                ELSE 5 END"),
                  created_at: :desc)
    else
      WorkOrder.includes(:asset)
            .order(Arel.sql("CASE priority
                                WHEN 'urgent' THEN 1
                                WHEN 'high'   THEN 2
                                WHEN 'normal' THEN 3
                                WHEN 'low'    THEN 4
                                ELSE 5 END"),
                  created_at: :desc)
    end
  end

  def show; end

  def new
    @work_order = (@asset ? @asset.work_orders.new : WorkOrder.new)
    @work_order.title       ||= params[:title]
    @work_order.priority    ||= params[:priority]
    @work_order.assigned_to ||= params[:assignee]
  end

  def create
    @work_order = (@asset ? @asset.work_orders.new(work_order_params) : WorkOrder.new(work_order_params))
    if @work_order.save
      redirect_to @work_order, notice: "Work order created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @work_order.update(work_order_params)
      redirect_to @work_order, notice: "Work order updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work_order.destroy!
    redirect_to (@work_order.asset ? asset_work_orders_path(@work_order.asset) : work_orders_path),
                status: :see_other, notice: "Work order deleted."
  end

  private

  def set_asset
    aid = params[:asset_id] || params.dig(:work_order, :asset_id)
    @asset = Asset.find(aid) if aid.present?
  end

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

  def work_order_params
    params.require(:work_order).permit(:asset_id, :title, :description, :status, :priority, :assigned_to)
  end
end
