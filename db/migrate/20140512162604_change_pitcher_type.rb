class ChangePitcherType < ActiveRecord::Migration
  def change
  	change_column :espn_games, :pitcher_a, :integer
  	change_column :espn_games, :pitcher_h, :integer
  end
end
