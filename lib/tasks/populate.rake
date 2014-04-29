require 'nokogiri'
require 'open-uri'
task :populate => :environment do
	@uri = ["http://xml.pinnaclesports.com/pinnacleFeed.aspx?last=1196336347638&sporttype=Basketball&sportsubtype=NBA", "http://xml.pinnaclesports.com/pinnacleFeed.aspx?last=1196336347638&sporttype=BaseBall&sportsubtype=MLB"]
	@uri.each do |uri|
		xml = Nokogiri::XML(open(uri))
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
				@pitcher = ""
				if participant.xpath('pitcher').present?
					@pitcher = participant.xpath('pitcher').text.to_s
				end	
				#Participants of Event Creation 
				@participant = Participant.create(:participant_name => @name, :contestantnum => @contestnum, :rotnum => @rotnum, :visiting_home_draw => @visiting, :event_id => @event.id, :pitcher => @pitcher)
				
				#Reading Odds of the Participant
				if participant.xpath('odds').present?
					participant.xpath('odds').each do |odd|
						@money = odd.xpath('moneyline_value').text.to_i
						@base = odd.xpath('to_base').text.to_i
						#Odds Creation
						@odd = Odd.create(:moneyline_value => @money, :to_base => @base, :participant_id => @participant.id)
					end
				end
			end
		end
	end	
end
