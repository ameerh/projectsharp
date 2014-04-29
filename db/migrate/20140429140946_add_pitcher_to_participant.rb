class AddPitcherToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :pitcher, :string
  end
end
