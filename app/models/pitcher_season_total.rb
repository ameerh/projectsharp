class PitcherSeasonTotal < ActiveRecord::Base
	belongs_to :pitcher
	attr_accessible :split, :W, :L, :W_L, :ERA, :G, :GS, :GF, :CG, :SHO, :SV, :IP, :H, :R, :ER, :HR, :BB, :IBB, :SO, :HBP, :BK, :WP, :BF, :WHIP, :SOp, :pitcher_id
end
