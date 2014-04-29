class CreateOdds < ActiveRecord::Migration
  def change
    create_table :odds do |t|
      t.integer :moneyline_value
      t.integer :to_base
      t.belongs_to :participant

      t.timestamps
    end
  end
end
