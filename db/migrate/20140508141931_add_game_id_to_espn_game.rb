class AddGameIdToEspnGame < ActiveRecord::Migration
  def change
    add_column :espn_games, :game_id, :integer
  end
end
