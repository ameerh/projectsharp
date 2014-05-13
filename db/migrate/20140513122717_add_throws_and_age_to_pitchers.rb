class AddThrowsAndAgeToPitchers < ActiveRecord::Migration
  def change
    add_column :pitchers, :throws, :string
    add_column :pitchers, :age, :float
    add_column :pitchers, :full_name, :string
  end
end
