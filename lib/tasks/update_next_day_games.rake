require 'nokogiri'
require 'open-uri'
task :update_next_day_games => :environment do
	@date = (Date.today+1).strftime("%Y%m%d") 
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
				@pitcher_a = game.css("#"+@game_id.to_s+"-awayStarter").first.children[1].text
				@pitcher_h = game.css("#"+@game_id.to_s+"-homeStarter").first.children[1].text
				
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
					@game_update = @game.update(:time => @time, :team_a => @team_away.id, :team_h => @team_home.id, :date => @date.to_s.to_date, :pitcher_a => @pitcher_a, :pitcher_h => @pitcher_h)
				else
					@game_create = EspnGame.create(:game_id => @game_id.to_i, :time => @time, :team_a => @team_away.id, :team_h => @team_home.id, :date => @date.to_s.to_date, :pitcher_a => @pitcher_a, :pitcher_h => @pitcher_h) 
				end
			end
		end
	endx	
end