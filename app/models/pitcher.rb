class Pitcher < ActiveRecord::Base
	attr_accessible :name, :url, :throws, :age, :full_name
	has_many :pitcher_season_totals
	has_many :pitcher_platoon_splits
	has_many :pitcher_home_away
end
