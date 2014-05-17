class PreviewsRulesController < ApplicationController
  before_action :set_previews_rule, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  layout "admin"

  # GET /previews_rules
  # GET /previews_rules.json
  def index
    @previews_rules = PreviewsRule.all
  end

  # GET /previews_rules/1
  # GET /previews_rules/1.json
  def show
  end

  # GET /previews_rules/new
  def new
    @previews_rule = PreviewsRule.new
    #Rules For
    @rules_for = {
      'Team'  => 'Team', 'Pitcher'   => 'Pitcher'
    }
    #Splits for Dropdown
    @splits = EspnTeamStat.select("split").where("split != 'record-position'").group("split")
    @split_list = Hash.new
    @splits.each do |split|
      @split_list[split.split] = split.split
    end
    @split_list['vs RHB'] = 'vs RHB'
    @split_list['vs LHB'] = 'vs LHB'
    #Column for Dropdown
    @column = {
      'G' => 'G', 'GS'  => 'GS', 'R'   => 'R', 'BA'  => 'BA', 'OBP' => 'OBP', 'SLG' => 'SLG',
      'W' => 'W', 'L' => 'L', 'W_L' => 'W_L', 'ERA' => 'ERA', 'GF' => 'GF', 'CG' => 'CG', 'SHO' => 'SHO', 'SV' => 'SV', 'IP' => 'IP', 'H' => 'H', 'ER' => 'ER', 'HR' => 'HR', 'BB' => 'BB', 'IBB' => 'IBB', 'SO' => 'SO', 'HBP' => 'HBP', 'BK' => 'BK', 'WP' => 'WP', 'BF' => 'BF', 'WHIP' => 'WHIP', 'SOp' => 'SO9', 
      'BA' => 'BA',
      'R/GS' => 'R/GS'
    }
    #Operators for Dropdown
    @operators = {
      '<'  => '<', '<='   => '<=', '>'  => '>', '>=' => '>=', '=' => '='
    }
  end

  # GET /previews_rules/1/edit
  def edit
    #Rules For
    @rules_for = {
      'Team'  => 'Team', 'Pitcher'   => 'Pitcher'
    }
    #Splits for Dropdown
    @splits = EspnTeamStat.select("split").where("split != 'record-position'").group("split")
    @split_list = Hash.new
    @splits.each do |split|
      @split_list[split.split] = split.split
    end
    @split_list['vs RHB'] = 'vs RHB'
    @split_list['vs LHB'] = 'vs LHB'
    #Column for Dropdown
    @column = {
      'G' => 'G', 'GS'  => 'GS', 'R'   => 'R', 'BA'  => 'BA', 'OBP' => 'OBP', 'SLG' => 'SLG',
      'W' => 'W', 'L' => 'L', 'W_L' => 'W_L', 'ERA' => 'ERA', 'GF' => 'GF', 'CG' => 'CG', 'SHO' => 'SHO', 'SV' => 'SV', 'IP' => 'IP', 'H' => 'H', 'ER' => 'ER', 'HR' => 'HR', 'BB' => 'BB', 'IBB' => 'IBB', 'SO' => 'SO', 'HBP' => 'HBP', 'BK' => 'BK', 'WP' => 'WP', 'BF' => 'BF', 'WHIP' => 'WHIP', 'SOp' => 'SOp', 
      'BA' => 'BA',
      'R/GS' => 'R/GS'
    }
    #Operators for Dropdown
    @operators = {
      '<'  => '<', '<='   => '<=', '>'  => '>', '>=' => '>=', '=' => '='
    }
  end

  # POST /previews_rules
  # POST /previews_rules.json
  def create
    @previews_rule = PreviewsRule.new(previews_rule_params)

    respond_to do |format|
      if @previews_rule.save
        format.html { redirect_to @previews_rule, notice: 'Previews rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @previews_rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @previews_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /previews_rules/1
  # PATCH/PUT /previews_rules/1.json
  def update
    respond_to do |format|
      if @previews_rule.update(previews_rule_params)
        format.html { redirect_to @previews_rule, notice: 'Previews rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @previews_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /previews_rules/1
  # DELETE /previews_rules/1.json
  def destroy
    @previews_rule.destroy
    respond_to do |format|
      format.html { redirect_to previews_rules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_previews_rule
      @previews_rule = PreviewsRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def previews_rule_params
      params[:previews_rule]
    end
end
