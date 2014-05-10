class StatRank < ActiveRecord::Base
	belongs_to :team_stat
	attr_accessible :at_bats, :runs_scored, :hits, :double_hit, :triple_hit, :home_run, :stolen_base, :caught_stealing, :bases_balls, :strikeout, :ba, :obp, :slg, :ops, :total_bases, :hbp, :sf, :team_stat_id
end
