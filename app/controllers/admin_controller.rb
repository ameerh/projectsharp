class AdminController < ApplicationController
  before_action :authenticate_user!
  layout "admin"
  def index
  end

  def pitchers
  	@pitchers = Pitcher.all
  end

  def previews_rules
  	binding.pry  	
  end	

end
