require 'nokogiri'
require 'open-uri'
task :update_next_day_games => :environment do
	start_date = Date.today 
	end_date   = Date.today + 5
	(start_date..end_date).each do |date| 
		@date = date.strftime("%Y%m%d") 
		puts "Scraping: " + date.to_s
		url = "http://scores.espn.go.com/mlb/scoreboard?date="+@date.to_s
		data = Nokogiri::HTML(open(url))

		@sides = ['#gamesLeft-1', '#gamesRight-1']
		@sides.each do |side|
			#Reading Side
			left_side = data.css(side)
			if left_side.present?
				@left_games = left_side.css(".mod-container")
				@left_games.each do |game|
					span = game.css("span")
					@game_id = span.first.attributes['id'].value.split("-")[0]
					#To Do Time Conversion
					@time    = game.css("#"+@game_id.to_s+"-statusLine1").first.children.first.text
					@team_a = game.css("#"+@game_id.to_s+"-aTeamName").first.children[0].children[0].text
					@team_h = game.css("#"+@game_id.to_s+"-hTeamName").first.children[0].children[0].text
					@pitcher_away = game.css("#"+@game_id.to_s+"-awayStarter").first.children[1].text
					@pitcher_home = game.css("#"+@game_id.to_s+"-homeStarter").first.children[1].text
					
					@pitcher_a = Pitcher.where(:name => @pitcher_away).first
					if @pitcher_a.blank? 
						@pitcher_a = Pitcher.create(:name => @pitcher_away)
					end

					@pitcher_home = game.css("#"+@game_id.to_s+"-homeStarter").first.children[1].text.to_s
					
					@pitcher_h = Pitcher.where(:name => @pitcher_home).first
					if @pitcher_h.blank? 
						@pitcher_h = Pitcher.create(:name => @pitcher_home)
					end

					@team_away = EspnTeam.where(:name => @team_a)
					if @team_away.blank?
						@team_away = EspnTeam.create(:name => @team_a)
					else
						@team_away = @team_away.first
					end
					@team_home = EspnTeam.where(:name => @team_h)
					if @team_home.blank?
						@team_home = EspnTeam.create(:name => @team_h)
					else
						@team_home = @team_home.first
					end
					@game = EspnGame.where(:game_id => @game_id).first
					if @game.present?
						@game_update = @game.update(:time => @time, :team_a => @team_away.id, :team_h => @team_home.id, :date => @date.to_s.to_date, :pitcher_a => @pitcher_a.id, :pitcher_h => @pitcher_h.id)
					else
						@game_create = EspnGame.create(:game_id => @game_id.to_i, :time => @time, :team_a => @team_away.id, :team_h => @team_home.id, :date => @date.to_s.to_date, :pitcher_a => @pitcher_a.id, :pitcher_h => @pitcher_h.id) 
					end
				end
			end
		end	
	end	
	#Remove Duplicates
	duplicates_query = "DELETE n1 FROM espn_games n1, espn_games n2 WHERE n1.id < n2.id AND n1.team_a = n2.team_a AND n1.team_h = n2.team_h AND n1.pitcher_a = n2.pitcher_a AND n1.pitcher_h = n2.pitcher_h AND n1.date = n2.date AND n1.time = n2.time"
	result = ActiveRecord::Base.connection.execute(duplicates_query)
end