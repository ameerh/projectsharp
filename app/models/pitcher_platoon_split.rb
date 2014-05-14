class PitcherPlatoonSplit < ActiveRecord::Base
	belongs_to :pitcher
	attr_accessible :split, :BA, :pitcher_id
end
