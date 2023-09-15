class CreatePlayAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :play_areas do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :num_courts
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
