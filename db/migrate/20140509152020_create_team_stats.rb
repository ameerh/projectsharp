class CreateTeamStats < ActiveRecord::Migration
  def change
    create_table :team_stats do |t|
      t.integer :game_played
      t.integer :runs_scored
      t.float :hits
      t.float :obp
      t.float :slg
      t.string :reacord
      t.string :position
      t.belongs_to :espn_team

      t.timestamps
    end
  end
end
