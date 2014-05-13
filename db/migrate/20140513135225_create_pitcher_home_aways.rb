class CreatePitcherHomeAways < ActiveRecord::Migration
  def change
    create_table :pitcher_home_aways do |t|
      t.string :split
      t.integer :W
      t.integer :L
      t.float :ERA
      t.float :GS
      t.float :WHIP
      t.belongs_to :pitcher

      t.timestamps
    end
  end
end
