class CreateEspnTeams < ActiveRecord::Migration
  def change
    create_table :espn_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
