class PitcherHomeAway < ActiveRecord::Base
	belongs_to :pitcher
	attr_accessible :split, :W, :L, :ERA, :GS, :WHIP, :pitcher_id
end
