class Odd < ActiveRecord::Base
	belongs_to :participant
	attr_accessible :moneyline_value, :to_base, :participant_id
end
