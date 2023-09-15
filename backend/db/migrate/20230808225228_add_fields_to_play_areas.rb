class AddFieldsToPlayAreas < ActiveRecord::Migration[7.0]
  def change
    add_column :play_areas, :net_height, :integer
    add_column :play_areas, :is_lined, :boolean
    add_column :play_areas, :is_public, :boolean
    add_column :play_areas, :has_rentals, :boolean
    add_column :play_areas, :has_restrooms, :boolean
  end
end
