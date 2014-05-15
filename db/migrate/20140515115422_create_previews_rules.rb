class CreatePreviewsRules < ActiveRecord::Migration
  def change
    create_table :previews_rules do |t|
      t.string :split
      t.string :column
      t.string :operator
      t.integer :value
      t.text :statement

      t.timestamps
    end
  end
end
