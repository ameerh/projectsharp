class TeamStat < ActiveRecord::Base
	belongs_to :espn_team
	has_one :stat_rank
	attr_accessible :game_played, :runs_scored, :hits, :obp, :slg, :reacord, :position, :espn_team_id
end
