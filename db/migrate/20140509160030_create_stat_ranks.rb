class CreateStatRanks < ActiveRecord::Migration
  def change
    create_table :stat_ranks do |t|
      t.integer :at_bats
      t.integer :runs_scored
      t.integer :hits
      t.integer :double_hit
      t.integer :triple_hit
      t.integer :home_run
      t.integer :stolen_base
      t.integer :caught_stealing
      t.integer :bases_balls
      t.integer :strikeout
      t.integer :ba
      t.integer :obp
      t.integer :slg
      t.integer :ops
      t.integer :total_bases
      t.integer :hbp
      t.integer :sf
      t.belongs_to :team_stat

      t.timestamps
    end
  end
end
