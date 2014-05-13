class CreatePitcherPlatoonSplits < ActiveRecord::Migration
  def change
    create_table :pitcher_platoon_splits do |t|
      t.string :split
      t.string :BA
      t.belongs_to :pitcher

      t.timestamps
    end
  end
end
