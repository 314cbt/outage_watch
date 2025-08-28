class AddStatusAndPriorityToWorkOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :work_orders, :status,   :string, null: false, default: "open"    unless column_exists?(:work_orders, :status)
    add_column :work_orders, :priority, :string, null: false, default: "normal"  unless column_exists?(:work_orders, :priority)
  end
end
