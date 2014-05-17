class ChangeDatatypeOfValue1PreviewsRules < ActiveRecord::Migration
  def change
	change_column :previews_rules, :value1,  :string
  end
end
