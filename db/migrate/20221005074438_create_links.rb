class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :orginurl
      t.string :slug
      t.integer :click

      t.timestamps
    end
  end
end
