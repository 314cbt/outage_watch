class CreateIncidents < ActiveRecord::Migration[7.1]
  def change
    create_table :incidents do |t|
      t.references :asset, null: false, foreign_key: true
      t.string :status
      t.string :severity
      t.datetime :started_at
      t.datetime :resolved_at
      t.string :cause
      t.text :notes

      t.timestamps
    end
  end
end
