class EspnTeam < ActiveRecord::Base
	attr_accessible :name, :url
	has_many :team_stats
end
