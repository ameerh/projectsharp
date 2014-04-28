class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :event_datetime
      t.integer :gamenumber
      t.string :sporttype
      t.string :league
      t.boolean :is_liveve

      t.timestamps
    end
  end
end
