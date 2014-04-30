class Event < ActiveRecord::Base
	has_many :participants
	has_many :periods
	attr_accessible :event_datetime, :gamenumber, :sporttype, :league, :is_live
end
