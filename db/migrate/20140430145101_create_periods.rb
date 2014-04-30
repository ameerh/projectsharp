class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :period_number
      t.string :period_description
      t.datetime :periodcutoff_datetime
      t.string :period_status
      t.string :period_update
      t.integer :spread_maximum
      t.integer :moneyline_maximum
      t.integer :total_maximum
      t.integer :moneyline_visiting
      t.integer :moneyline_home
      t.float :spread_visiting
      t.integer :spread_adjust_visiting
      t.float :spread_home
      t.integer :spread_adjust_home
      t.integer :tootal_point
      t.integer :over_adjust
      t.integer :under_adjust
      t.belongs_to :event

      t.timestamps
    end
  end
end
