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
		    @eve = Event.where(:gamenumber => @gamenumber)
		    if @eve.present?
		    	@event = @eve.first
		    	@event = @event.update(:event_datetime => @datetime, :gamenumber => @gamenumber, :sporttype => @sporttype, :league => @league, :is_liveve => @islive)
		    	event.xpath('participants/participant').each_with_index do |participant, i|
					@name = participant.xpath('participant_name').text.to_s
					@contestnum = participant.xpath('contestantnum').text.to_i
					@rotnum = participant.xpath('rotnum').text.to_i
					@visiting = participant.xpath('visiting_home_draw').text.to_s
					@pitcher = ""
					if participant.xpath('pitcher').present?
						@pitcher = participant.xpath('pitcher').text.to_s
					end	
					#Participants of Event Creation 
					@part = Participant.where(:event_id => @eve.first.id)
					@part = @part[i] 
					@participant = @part.update(:participant_name => @name, :contestantnum => @contestnum, :rotnum => @rotnum, :visiting_home_draw => @visiting, :pitcher => @pitcher)
					
					#Reading Odds of the Participant
					if participant.xpath('odds').present?
						participant.xpath('odds').each do |odd|
							@money = odd.xpath('moneyline_value').text.to_i
							@base = odd.xpath('to_base').text.to_i
							#Odds Creation
							@od = Odd.where(:participant_id => @part.id).first
							@odd = @od.update(:moneyline_value => @money, :to_base => @base)
						end
					end
				end
				#Reading Period of Event 
				if event.xpath('periods/period').present? 
					event.xpath('periods/period').each do |period|
						@period_number = period.xpath('period_number').text.to_i
						@period_desc = period.xpath('period_description').text.to_s
						@periodcutoff_datetime = period.xpath('periodcutoff_datetimeGMT').text.to_datetime
						@period_status = period.xpath('period_status').text.to_s
						@period_update = period.xpath('period_update').text.to_s
						@spread_maximum = period.xpath('spread_maximum').text.to_i
						@moneyline_maximum = period.xpath('moneyline_maximum').text.to_i
						@total_maximum = period.xpath('total_maximum').text.to_i
						@moneyline_visiting = 0
						@moneyline_home = 0
						#Reading Moneyline of Period
						if period.xpath('moneyline').present?
							period.xpath('moneyline').each do |money|
								@moneyline_visiting = money.xpath('moneyline_visiting').text.to_i
								@moneyline_home = money.xpath('moneyline_home').text.to_i
							end
						end
						@spread_visiting = 0.0
						@spread_adjust_visiting = 0
						@spread_home = 0.0
						@spread_adjust_home = 0	
						#Reading Spread of Period			
						if period.xpath('spread').present?
							period.xpath('spread').each do |spread|
								@spread_visiting = spread.xpath('spread_visiting').text.to_f
								@spread_adjust_visiting = spread.xpath('spread_adjust_visiting').text.to_i
								@spread_home = spread.xpath('spread_home').text.to_f
								@spread_adjust_home = spread.xpath('spread_adjust_home').text.to_i
							end
						end
						@total_points = 0
						@over_adjust = 0
						@under_adjust = 0
						#Reading Total of Period
						if period.xpath('total').present?
							period.xpath('total').each do |total|
								@total_points = total.xpath('total_points').text.to_i
								@over_adjust = total.xpath('over_adjust').text.to_i
								@under_adjust = total.xpath('under_adjust').text.to_i
							end
						end
						#Creating Periods
						@per = Period.where(:event_id => @eve.first.id).first
						@period = @per.update(:period_number => @period_number, :period_description => @period_desc, :periodcutoff_datetime => @periodcutoff_datetime, :period_status => @period_status, :period_update => @period_update, :spread_maximum => @spread_maximum, :moneyline_maximum => @moneyline_maximum, :total_maximum => @total_maximum, :moneyline_visiting => @moneyline_visiting, :moneyline_home => @moneyline_home, :spread_visiting => @spread_visiting, :spread_adjust_visiting => @spread_adjust_visiting, :spread_home => @spread_home, :spread_adjust_home => @spread_adjust_home, :tootal_point => @total_points, :over_adjust => @over_adjust, :under_adjust => @under_adjust)
					end
				end
		    else	
		    	@event = Event.create(:event_datetime => @datetime, :gamenumber => @gamenumber, :sporttype => @sporttype, :league => @league, :is_liveve => @islive)
		    	#Reading Participants of Events
				event.xpath('participants/participant').each do |participant|
					@name = participant.xpath('participant_name').text.to_s
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
				#Reading Period of Event 
				if event.xpath('periods/period').present? 
					event.xpath('periods/period').each do |period|
						@period_number = period.xpath('period_number').text.to_i
						@period_desc = period.xpath('period_description').text.to_s
						@periodcutoff_datetime = period.xpath('periodcutoff_datetimeGMT').text.to_datetime
						@period_status = period.xpath('period_status').text.to_s
						@period_update = period.xpath('period_update').text.to_s
						@spread_maximum = period.xpath('spread_maximum').text.to_i
						@moneyline_maximum = period.xpath('moneyline_maximum').text.to_i
						@total_maximum = period.xpath('total_maximum').text.to_i
						@moneyline_visiting = 0
						@moneyline_home = 0
						#Reading Moneyline of Period
						if period.xpath('moneyline').present?
							period.xpath('moneyline').each do |money|
								@moneyline_visiting = money.xpath('moneyline_visiting').text.to_i
								@moneyline_home = money.xpath('moneyline_home').text.to_i
							end
						end
						@spread_visiting = 0.0
						@spread_adjust_visiting = 0
						@spread_home = 0.0
						@spread_adjust_home = 0	
						#Reading Spread of Period			
						if period.xpath('spread').present?
							period.xpath('spread').each do |spread|
								@spread_visiting = spread.xpath('spread_visiting').text.to_f
								@spread_adjust_visiting = spread.xpath('spread_adjust_visiting').text.to_i
								@spread_home = spread.xpath('spread_home').text.to_f
								@spread_adjust_home = spread.xpath('spread_adjust_home').text.to_i
							end
						end
						@total_points = 0
						@over_adjust = 0
						@under_adjust = 0
						#Reading Total of Period
						if period.xpath('total').present?
							period.xpath('total').each do |total|
								@total_points = total.xpath('total_points').text.to_i
								@over_adjust = total.xpath('over_adjust').text.to_i
								@under_adjust = total.xpath('under_adjust').text.to_i
							end
						end
						#Creating Periods
						@period = Period.create(:event_id => @event.id, :period_number => @period_number, :period_description => @period_desc, :periodcutoff_datetime => @periodcutoff_datetime, :period_status => @period_status, :period_update => @period_update, :spread_maximum => @spread_maximum, :moneyline_maximum => @moneyline_maximum, :total_maximum => @total_maximum, :moneyline_visiting => @moneyline_visiting, :moneyline_home => @moneyline_home, :spread_visiting => @spread_visiting, :spread_adjust_visiting => @spread_adjust_visiting, :spread_home => @spread_home, :spread_adjust_home => @spread_adjust_home, :tootal_point => @total_points, :over_adjust => @over_adjust, :under_adjust => @under_adjust)
					end
				end
		    end				
		end
	end	
end
