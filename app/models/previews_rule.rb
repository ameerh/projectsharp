class PreviewsRule < ActiveRecord::Base
	attr_accessible :rule_for, :split, :column, :operator1, :value1, :operator2, :value2, :statement
end
