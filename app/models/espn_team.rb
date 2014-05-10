class EspnTeam < ActiveRecord::Base
	attr_accessible :name
	has_many :team_stats
end
