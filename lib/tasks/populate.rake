require 'nokogiri'
require 'open-uri'
task :populate => :environment do
	@uri = "http://xml.pinnaclesports.com/pinnacleFeed.aspx?sportType=Basketball&sportsubtype=NBA"
	xml = Nokogiri::XML(open(@uri))
	#Reading Events
	xml.xpath("//events/event").each do |event|
	    @datetime = event.xpath('event_datetimeGMT').text.to_datetime
	    @gamenumber = event.xpath('gamenumber').text.to_i
	    @league = event.xpath('league').text.to_s
	    @sporttype = event.xpath('sporttype').text.to_s
	    @islive = event.xpath('IsLive').text.to_s
	    #Event Creation
	    @event = Event.create(:event_datetime => @datetime, :gamenumber => @gamenumber, :sporttype => @sporttype, :league => @league, :is_liveve => @islive)

		#Reading Participants of Events
		event.xpath('participants/participant').each do |participant|
			@name = participant.xpath('particicipant_name').text.to_s
		    @contestnum = participant.xpath('contestantnum').text.to_i
		    @rotnum = participant.xpath('rotnum').text.to_i
		    @visiting = participant.xpath('visiting_home_draw').text.to_s	
		    #Participants of Event Creation 
			@participant = Participant.create(:participant_name => @name, :contestantnum => @contestnum, :rotnum => @rotnum, :visiting_home_draw => @visiting, :event_id => @event.id)
		end
	end
end