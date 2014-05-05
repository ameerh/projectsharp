class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_timezone 

  def set_timezone  
	# time_zone_string = "GMT-1:00"
	# offset = time_zone_string.match(/GMT(\+|-)(\d+):(\d+)/) { "#{$1}1".to_i * ($2.to_i.hours + $3.to_i.minutes) }
	# time_zone = ActiveSupport::TimeZone.new(offset)

	# binding.pry

	min = request.cookies["time_zone"].to_i
	Time.zone = ActiveSupport::TimeZone[-min.minutes]
	puts Time.zone.to_s
  end 
end
