class CreateIncidentEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :incident_events do |t|
      t.references :incident, null: false, foreign_key: true
      t.string :kind
      t.datetime :occurred_at
      t.text :message

      t.timestamps
    end
  end
end
