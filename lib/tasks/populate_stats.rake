require 'nokogiri'
require 'open-uri'
task :populate_stats => :environment do
	@teams = EspnTeam.all
		@teams.each do |team|	
			url = team.url
			data = Nokogiri::HTML(open(url))
			@record = data.css("#info_box").first.css("p").children[5].text.to_s
			@position = data.css("#info_box").first.css("p").children[6].text.split(', ')[1].to_s
			@game_played = data.css(".stat_total").first.children[8].text.to_i
			@runs_scored = data.css(".stat_total").first.children[14].text.to_i
			@hits = data.css(".stat_total").first.children[34].text.to_f
			@obp = data.css(".stat_total").first.children[36].text.to_f
			@slg = data.css(".stat_total").first.children[38].text.to_f
			@team_id = team.id
			@team_stat = TeamStat.create(:game_played => @game_played, :runs_scored => @runs_scored, :hits => @hits, :obp => @obp, :slg => @slg, :reacord => @record, :position => @position, :espn_team_id => @team_id)
			
			@at_bats = data.css(".stat_total")[1].children[12].text.to_i
			@runs_score = data.css(".stat_total")[1].children[14].text.to_i
			@hit = data.css(".stat_total")[1].children[16].text.to_i
			@double_hit = data.css(".stat_total")[1].children[18].text.to_i
			@triple_hit = data.css(".stat_total")[1].children[20].text.to_i
			@home_run = data.css(".stat_total")[1].children[22].text.to_i
			@stolen_base = data.css(".stat_total")[1].children[26].text.to_i
			@caught_stealing = data.css(".stat_total")[1].children[28].text.to_i
			@bases_balls = data.css(".stat_total")[1].children[30].text.to_i
			@strikeout = data.css(".stat_total")[1].children[32].text.to_i
			@ba = data.css(".stat_total")[1].children[34].text.to_i
			@obps = data.css(".stat_total")[1].children[36].text.to_i
			@slgs = data.css(".stat_total")[1].children[38].text.to_i
			@ops = data.css(".stat_total")[1].children[40].text.to_i
			@total_bases = data.css(".stat_total")[1].children[44].text.to_i
			@hbp = data.css(".stat_total")[1].children[48].text.to_i
			@sf = data.css(".stat_total")[1].children[52].text.to_i

			@stat_rank = StatRank.create(:at_bats => @at_bats, :runs_scored => @runs_score, :hits => @hit, :double_hit => @double_hit, :triple_hit => @triple_hit, :home_run => @home_run, :stolen_base => @stolen_base, :caught_stealing => @caught_stealing, :bases_balls => @bases_balls, :strikeout => @strikeout, :ba => @ba, :obp => @obps, :slg => @slgs, :ops => @ops, :total_bases => @total_bases, :hbp => @hbp, :sf => @sf, :team_stat_id => @team_stat.id)
		end	
end