class ChangeliveName < ActiveRecord::Migration
  def change
  	rename_column :events, :is_liveve, :is_live
  end
end
