class EspnGamesController < ApplicationController
  before_action :set_espn_game, only: [:show, :edit, :update, :destroy]

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
    if params[:team_a].present? && params[:team_h].present?
      @team_a = EspnTeam.find(params[:team_a])
      @team_a_stats = EspnTeamStats.where("espn_team_id=?",params[:team_a])
      @team_h = EspnTeam.find(params[:team_h])
      @team_h_stats = EspnTeamStats.where("espn_team_id=?",params[:team_h])
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
end
