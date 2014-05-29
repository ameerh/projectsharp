class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_timezone 

  def set_timezone  
  	min = request.cookies["time_zone"].to_i
  	Time.zone = ActiveSupport::TimeZone[-min.minutes]
    $my_time_zone = Time.zone.to_s
  	puts Time.zone.to_s
  end 

  def after_sign_in_path_for(resource)
  	"/admin"
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
