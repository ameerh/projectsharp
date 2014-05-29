class MlbController < ApplicationController
  helper_method :check_condition
  layout "wp_application"


  def index
    if params[:date].present?
      @date = params[:date]
    else
      @date = Date.today
    end
    @espn_games = EspnGame.where(:date => @date).order('TIME(time) ASC')  	
	render :layout => "2_column"
  end	

  def mlb_picks
  	if(params[:id].present?)
  		#parmters from url
  		url    = params[:id]
  		params = url.split("-predictions-")
  		if(params.first.include? "-vs-")
	  		teams  = params.first.split("-vs-")
	  		team_a = teams.first
	  		team_b = teams.last
	  	end	

		begin
	  		date   = Date::strptime(params.last, "%Y-%d-%m")
		rescue ArgumentError
			date = nil
		end
		if(team_a.nil? || team_b.nil? || date.nil?)
	  		redirect_to "/"
		end

		#Get Game
		@team_a = EspnTeam.where("name LIKE '%#{team_a}%'").first
		@team_b = EspnTeam.where("name LIKE '%#{team_b}%'").first
		if(@team_a.present? && @team_b.present?)
			@game = EspnGame.where("((team_a = ? AND team_h = ?) OR (team_a = ? AND team_h = ?)) AND date = ?",@team_a.id,@team_b.id,@team_b.id,@team_a.id,date).first
			if(@game.present?)
		      #Teams Stats
		      @team_a = EspnTeam.find(@game.team_a)
		      @team_h = EspnTeam.find(@game.team_h)
		      #Pitchers Stats
		      # @game.pitcher_a = 116
		      # @game.pitcher_h = 116
		      @pitcher_a = Pitcher.find(@game.pitcher_a)
		      @pitcher_h = Pitcher.find(@game.pitcher_h)

		      #Previews Rules
		      @team_previews_rules    = PreviewsRule.all.where("rule_for='Team'")
		      @pitcher_previews_rules = PreviewsRule.all.where("rule_for='Pitcher'")

		      #Odds
		      events = Event.where("DATE(event_datetime) = ? AND league = 'MLB'",@game.date)
		      events.each do |event|
		        if(event.participants.first.participant_name.include? @team_a.name) || (event.participants.last.participant_name.include? @team_h.name)
		          @event = event
		        end  
		      end
		      #binding.pry

		      @title  = "#{@team_h.name} VS #{@team_a.name} Perdiction - #{date}"
		      set_meta_tags :title => @title
		      set_meta_tags :description => "100% Free Betting Advice. #{@team_a.name} vs #{@team_h.name} Prediction Against The Spread, Totals and Moneyline plays."
		      render :layout => "1_column"
		  	else
		  		redirect_to "/"
			end			
	  	else
	  		redirect_to "/"
		end	
  	else
  		redirect_to "/"
  	end		
  end 	 	

end
