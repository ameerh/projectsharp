class EspnTeam < ActiveRecord::Base
	attr_accessible :name, :url
	has_many :espn_team_stats
end
