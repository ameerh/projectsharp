class Participant < ActiveRecord::Base
	belongs_to :event
	has_one :odd
	attr_accessible :participant_name, :contestantnum, :rotnum, :visiting_home_draw, :event, :event_id, :pitcher
end
