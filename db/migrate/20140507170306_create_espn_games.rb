class CreateEspnGames < ActiveRecord::Migration
  def change
    create_table :espn_games do |t|
      t.integer :team_a
      t.integer :team_h
      t.time :time
      t.date :date
      t.string :pitcher_a
      t.string :pitcher_h

      t.timestamps
    end
  end
end
