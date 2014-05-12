class EspnTeamStats < ActiveRecord::Base
	belongs_to :espn_team
	attr_accessible :split, :GS, :R, :BA, :OBP, :SLG, :reacord, :position, :espn_team_id
end
