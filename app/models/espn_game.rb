class EspnGame < ActiveRecord::Base
	attr_accessible :pitcher_a, :pitcher_h, :time, :date, :team_a, :team_h, :game_id
	belongs_to :games
end
