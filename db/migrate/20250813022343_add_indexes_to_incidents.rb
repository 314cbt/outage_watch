class AddIndexesToIncidents < ActiveRecord::Migration[7.1]
  def change
    add_index :incidents, :status
    add_index :incidents, :severity
    add_index :incidents, :started_at
  end
end
  