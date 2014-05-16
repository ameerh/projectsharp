class DualConditionsInRules < ActiveRecord::Migration
  def change
  	rename_column :previews_rules, :operator, :operator1
  	rename_column :previews_rules, :value, :value1
	add_column :previews_rules, :operator2, :string
	add_column :previews_rules, :value2, :string
  end
end
