class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :winner_team, foreign_key: { to_table: :teams }, null: false
      t.references :other_team, foreign_key: { to_table: :teams }, null: false
      t.references :play_area, foreign_key: true, null: false
      t.boolean :is_validated, default: false, null: false
      t.references :created_by, foreign_key: { to_table: :players }, null: false
      t.timestamps null: false
    end
  end
end
