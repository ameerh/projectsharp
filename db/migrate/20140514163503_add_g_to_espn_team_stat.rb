class AddGToEspnTeamStat < ActiveRecord::Migration
  def change
    add_column :espn_team_stats, :G, :integer
  end
end
