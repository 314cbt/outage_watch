class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.string :name
      t.string :category
      t.string :status
      t.decimal :latitude
      t.decimal :longitude
      t.jsonb :metadata

      t.timestamps
    end
  end
end
