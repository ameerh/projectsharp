require 'nokogiri'
require 'open-uri'
task :populate_teams_stats_p => :environment do
	# @teams = EspnTeam.find(:all, :order => "id desc")
	# @teams = EspnTeam.where("id=29")
	@teams = EspnTeam.all
	@teams.each do |team|	
		url = team.url
		data = Nokogiri::HTML(open(url).read, nil, 'utf-8')
		@team_id = team.id

		#Team Record & Position
		@record   = data.css("#info_box").children[5].children[0].text.to_s
		@position = data.css("#info_box").children[5].children[1].text.split(', ')[1].to_s
		@split	  = "record-position"

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@record_position = @EspnTeamStat.update(:split => @split, :record => @record, :position => @position, :espn_team_id => @team_id)
		else
			@record_position = EspnTeamStat.create(:split => @split, :record => @record, :position => @position, :espn_team_id => @team_id)
		end	
		#Season Totals Section Scraping
		#Current year totals
		@split    = data.css("#total tbody tr")[0].css("td[1]").first.text.to_s
		@G        = data.css("#total tbody tr")[0].css("td[2]").first.text.to_s
		@GS       = data.css("#total tbody tr")[0].css("td[3]").first.text.to_s
		@R        = data.css("#total tbody tr")[0].css("td[6]").first.text.to_s
		@BA       = data.css("#total tbody tr")[0].css("td[16]").first.text.to_s
		@OBP      = data.css("#total tbody tr")[0].css("td[17]").first.text.to_s
		@SLG      = data.css("#total tbody tr")[0].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@current_year_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@current_year_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#Last 7Days totals
		@split    = data.css("#total tbody tr")[1].css("td[1]").first.text.to_s
		@G        = data.css("#total tbody tr")[1].css("td[2]").first.text.to_s
		@GS       = data.css("#total tbody tr")[1].css("td[3]").first.text.to_s
		@R        = data.css("#total tbody tr")[1].css("td[6]").first.text.to_s
		@BA       = data.css("#total tbody tr")[1].css("td[16]").first.text.to_s
		@OBP      = data.css("#total tbody tr")[1].css("td[17]").first.text.to_s
		@SLG      = data.css("#total tbody tr")[1].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@last7_days_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@last7_days_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#Last 28Days totals
		@split    = data.css("#total tbody tr")[3].css("td[1]").first.text.to_s
		@G        = data.css("#total tbody tr")[3].css("td[2]").first.text.to_s
		@GS       = data.css("#total tbody tr")[3].css("td[3]").first.text.to_s
		@R        = data.css("#total tbody tr")[3].css("td[6]").first.text.to_s
		@BA       = data.css("#total tbody tr")[3].css("td[16]").first.text.to_s
		@OBP      = data.css("#total tbody tr")[3].css("td[17]").first.text.to_s
		@SLG      = data.css("#total tbody tr")[3].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@last28_days_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@last28_days_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#Platoon Splits Section Scraping
		#vs RHP
		@split    = data.css("#plato tbody tr")[0].css("td[1]").first.text.to_s
		@G        = data.css("#plato tbody tr")[0].css("td[2]").first.text.to_s
		@GS       = data.css("#plato tbody tr")[0].css("td[3]").first.text.to_s
		@R        = data.css("#plato tbody tr")[0].css("td[6]").first.text.to_s
		@BA       = data.css("#plato tbody tr")[0].css("td[16]").first.text.to_s
		@OBP      = data.css("#plato tbody tr")[0].css("td[17]").first.text.to_s
		@SLG      = data.css("#plato tbody tr")[0].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@vs_rhp_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@vs_rhp_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#vs LHP
		@split    = data.css("#plato tbody tr")[1].css("td[1]").first.text.to_s
		@G        = data.css("#plato tbody tr")[1].css("td[2]").first.text.to_s
		@GS       = data.css("#plato tbody tr")[1].css("td[3]").first.text.to_s
		@R        = data.css("#plato tbody tr")[1].css("td[6]").first.text.to_s
		@BA       = data.css("#plato tbody tr")[1].css("td[16]").first.text.to_s
		@OBP      = data.css("#plato tbody tr")[1].css("td[17]").first.text.to_s
		@SLG      = data.css("#plato tbody tr")[1].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@vs_lhp_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@vs_lhp_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#Home or Away Section Scraping
		#Home
		@split    = data.css("#hmvis tbody tr")[0].css("td[1]").first.text.to_s
		@G        = data.css("#hmvis tbody tr")[0].css("td[2]").first.text.to_s
		@GS       = data.css("#hmvis tbody tr")[0].css("td[3]").first.text.to_s
		@R        = data.css("#hmvis tbody tr")[0].css("td[6]").first.text.to_s
		@BA       = data.css("#hmvis tbody tr")[0].css("td[16]").first.text.to_s
		@OBP      = data.css("#hmvis tbody tr")[0].css("td[17]").first.text.to_s
		@SLG      = data.css("#hmvis tbody tr")[0].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@home_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@home_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	

		#Away
		@split    = data.css("#hmvis tbody tr")[1].css("td[1]").first.text.to_s
		@G        = data.css("#hmvis tbody tr")[1].css("td[2]").first.text.to_s
		@GS       = data.css("#hmvis tbody tr")[1].css("td[3]").first.text.to_s
		@R        = data.css("#hmvis tbody tr")[1].css("td[6]").first.text.to_s
		@BA       = data.css("#hmvis tbody tr")[1].css("td[16]").first.text.to_s
		@OBP      = data.css("#hmvis tbody tr")[1].css("td[17]").first.text.to_s
		@SLG      = data.css("#hmvis tbody tr")[1].css("td[18]").first.text.to_s

		@EspnTeamStat = EspnTeamStat.where("split=? AND espn_team_id=?",@split,@team_id).first
		if @EspnTeamStat.present?
			@away_total = @EspnTeamStat.update(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		else
			@away_total = EspnTeamStat.create(:split => @split, :G => @G, :GS => @GS, :R => @R, :BA => @BA, :OBP => @OBP, :SLG => @SLG, :espn_team_id => @team_id)
		end	
		
		puts "#{team.id}. #{team.name} Stats have been scraped succesfully"					
	end	
end