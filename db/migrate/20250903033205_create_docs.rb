class CreateDocs < ActiveRecord::Migration[7.1]
  def change
    create_table :docs do |t|
      t.string :slug
      t.string :title

      t.timestamps
    end
    add_index :docs, :slug
  end
end
