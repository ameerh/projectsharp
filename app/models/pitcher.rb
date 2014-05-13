class Pitcher < ActiveRecord::Base
	attr_accessible :name, :url, :throws, :age, :full_name
end
