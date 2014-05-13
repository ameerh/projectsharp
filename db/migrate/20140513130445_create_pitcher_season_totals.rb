class CreatePitcherSeasonTotals < ActiveRecord::Migration
  def change
    create_table :pitcher_season_totals do |t|
      t.string :split
      t.integer :W
      t.integer :L
      t.float :W_L
      t.float :ERA
      t.integer :G
      t.integer :GS
      t.integer :GF
      t.integer :CG
      t.integer :SHO
      t.integer :SV
      t.integer :IP
      t.integer :H
      t.integer :R
      t.integer :ER
      t.integer :HR
      t.integer :BB
      t.integer :IBB
      t.integer :SO
      t.integer :HBP
      t.integer :BK
      t.integer :WP
      t.integer :BF
      t.float :WHIP
      t.float :SOp
      t.belongs_to :pitcher

      t.timestamps
    end
  end
end
