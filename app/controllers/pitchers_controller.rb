class PitchersController < ApplicationController
  before_action :set_pitcher, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  layout "admin"

  # GET /pitchers
  # GET /pitchers.json
  def index
    @pitchers = Pitcher.all.order('name ASC').paginate(:page => params[:page], :per_page => 10)
  end

  # GET /pitchers/1
  # GET /pitchers/1.json
  def show
  end

  # GET /pitchers/new
  def new
    @pitcher = Pitcher.new
  end

  # GET /pitchers/1/edit
  def edit
  end

  # POST /pitchers
  # POST /pitchers.json
  def create
    @pitcher = Pitcher.new(pitcher_params)

    respond_to do |format|
      if @pitcher.save
        format.html { redirect_to @pitcher, notice: 'Pitcher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pitcher }
      else
        format.html { render action: 'new' }
        format.json { render json: @pitcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitchers/1
  # PATCH/PUT /pitchers/1.json
  def update
    respond_to do |format|
      if @pitcher.update(pitcher_params)
        format.html { redirect_to @pitcher, notice: 'Pitcher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pitcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitchers/1
  # DELETE /pitchers/1.json
  def destroy
    @pitcher.destroy
    respond_to do |format|
      format.html { redirect_to pitchers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pitcher
      @pitcher = Pitcher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pitcher_params
      params[:pitcher]
    end
end
