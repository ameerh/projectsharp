class Period < ActiveRecord::Base
	belongs_to :event
	attr_accessible :period_number, :period_description, :periodcutoff_datetime, :period_status, :period_update, :spread_maximum, :moneyline_maximum, :total_maximum, :moneyline_visiting, :moneyline_home, :spread_visiting, :spread_adjust_visiting, :spread_home, :spread_adjust_home, :tootal_point, :over_adjust, :under_adjust
end
