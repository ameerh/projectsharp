class EspnTeamStat < ActiveRecord::Base
	belongs_to :espn_team
	attr_accessible :split, :G, :GS, :R, :BA, :OBP, :SLG, :record, :position, :espn_team_id
end
