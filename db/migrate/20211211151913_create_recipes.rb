class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name, nill: false
      t.integer :survings, null: false
      t.integer :category, null: false, default: 0
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
