class CreateEspnTeamStats < ActiveRecord::Migration
  def change
    create_table :espn_team_stats do |t|
      t.string :split
      t.string :GS
      t.string :R
      t.string :BA
      t.string :OBP
      t.string :SLG
      t.string :record
      t.string :position
      t.belongs_to :espn_team

      t.timestamps
    end
  end
end
