class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  helper_method :check_condition

  # GET /events
  # GET /events.json
  def index
    @events = Event.where("(league = ? OR league = ?) AND event_datetime >= ?", "NBA", "MLB",  Time.now.to_datetime).order('event_datetime ASC').limit(5)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def nba
    @events = Event.where("league = ? AND event_datetime >= ?", "NBA", Time.now.to_datetime).order('event_datetime ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def mlb
    @events = Event.where("league = ? AND event_datetime >= ?", "MLB", Time.now.to_datetime).order('event_datetime ASC').paginate(:page => params[:page], :per_page => 20)
  end

  def previews
    if params[:team_a].present? && params[:team_b].present?
      #Teams Stats
      team_a  = params[:team_a].split(" ").last 
      team_h  = params[:team_b].split(" ").last 

      @team_a = EspnTeam.where("name like ?", "%#{team_a}%").first
      @team_h = EspnTeam.where("name like ?", "%#{team_h}%").first
      @title  = "#{@team_h.name} VS #{@team_a.name} Perdiction - #{params[:date]}"

      set_meta_tags :title => @title
      set_meta_tags :description => "100% Free Betting Advice. #{@team_a.name} vs #{@team_h.name} Prediction Against The Spread, Totals and Moneyline plays."
    end  
    if params[:pitcher_a].present? && params[:pitcher_b].present?
      #Pitchers Stats
      pitcher_a  = params[:pitcher_a].split(" ").last 
      pitcher_h  = params[:pitcher_b].split(" ").last 

      @pitcher_a = EspnTeam.where("name like ?", "%#{pitcher_a}%").first
      @pitcher_h = EspnTeam.where("name like ?", "%#{pitcher_h}%").first

      pitcher_a = 116
      pitcher_h = 116
      @pitcher_a = Pitcher.find(pitcher_a)
      @pitcher_h = Pitcher.find(pitcher_h)
    end  
    #Previews Rules
    @team_previews_rules    = PreviewsRule.all.where("rule_for='Team'")
    @pitcher_previews_rules = PreviewsRule.all.where("rule_for='Pitcher'")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event]
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
