class CreateRosterRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :roster_records do |t|
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.datetime :joined_at
      t.datetime :left_at
      t.boolean :is_active

      t.timestamps
    end
  end
end
