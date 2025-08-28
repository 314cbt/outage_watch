class CreateWorkOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :work_orders do |t|
      t.references :asset, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :scheduled_for
      t.string :status

      t.timestamps
    end
  end
end
