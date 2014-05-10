class AddUrlToEspnTeam < ActiveRecord::Migration
  def change
    add_column :espn_teams, :url, :string
  end
end
