class AddAssignedToToWorkOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :work_orders, :assigned_to, :string
  end
end
