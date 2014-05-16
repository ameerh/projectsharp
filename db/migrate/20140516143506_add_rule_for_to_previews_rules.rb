class AddRuleForToPreviewsRules < ActiveRecord::Migration
  def change
    add_column :previews_rules, :rule_for, :string
  end
end
