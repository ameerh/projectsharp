class Event < ActiveRecord::Base
	has_many :participants
	attr_accessible :event_datetime, :gamenumber, :sporttype, :league, :is_liveve
end
