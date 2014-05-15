class PreviewsRule < ActiveRecord::Base
	attr_accessible :split, :column, :operator, :value, :statement
end
