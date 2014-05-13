class AddUrlToPitchers < ActiveRecord::Migration
  def change
    add_column :pitchers, :url, :string
  end
end
