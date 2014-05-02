class CreateFeedtimes < ActiveRecord::Migration
  def change
    create_table :feedtimes do |t|
      t.integer :feedtime, :limit => 8

      t.timestamps
    end
  end
end
