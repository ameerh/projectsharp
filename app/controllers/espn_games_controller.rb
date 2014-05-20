class EspnGamesController < ApplicationController
  before_action :set_espn_game, only: [:show, :edit, :update, :destroy]
  helper_method :check_condition

  # GET /espn_games
  # GET /espn_games.json
  def index
    if params[:date].present?
      @date = params[:date]
    else
      @date = Date.today
    end
    @espn_games = EspnGame.where(:date => @date).order('time ASC')
  end

  # GET /espn_games/1
  # GET /espn_games/1.json
  def show
  end

  # GET /espn_games/new
  def new
    @espn_game = EspnGame.new
  end

  # GET /espn_games/1/edit
  def edit
  end

  # POST /espn_games
  # POST /espn_games.json
  def create
    @espn_game = EspnGame.new(espn_game_params)

    respond_to do |format|
      if @espn_game.save
        format.html { redirect_to @espn_game, notice: 'Espn game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @espn_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @espn_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /espn_games/1
  # PATCH/PUT /espn_games/1.json
  def update
    respond_to do |format|
      if @espn_game.update(espn_game_params)
        format.html { redirect_to @espn_game, notice: 'Espn game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @espn_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /espn_games/1
  # DELETE /espn_games/1.json
  def destroy
    @espn_game.destroy
    respond_to do |format|
      format.html { redirect_to espn_games_url }
      format.json { head :no_content }
    end
  end

  def previews
    if params[:game].present?
      @game   = EspnGame.find(params[:game])
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

      @title  = "#{@team_h.name} VS #{@team_a.name} Perdiction - #{params[:date]}"
      set_meta_tags :title => @title
      set_meta_tags :description => "100% Free Betting Advice. #{@team_a.name} vs #{@team_h.name} Prediction Against The Spread, Totals and Moneyline plays."
    else
      redirect_to "/espn_games"
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_espn_game
      @espn_game = EspnGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def espn_game_params
      params[:espn_game]
    end
    
    def check_condition(operator, value1, value2)
      if operator == ">"
        return value1 > value2
      elsif operator == ">="
        return value1 >= value2
      elsif operator == "<"
        return value1 < value2
      elsif operator == "<="
        return value1 <= value2
      elsif operator == "=="
        return value1 == value2
      end  
    end
end
