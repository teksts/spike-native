class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :avatar_picture
      t.text :description
      t.integer :elo_rating

      t.timestamps
    end
  end
end
