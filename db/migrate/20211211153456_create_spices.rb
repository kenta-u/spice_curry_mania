class CreateSpices < ActiveRecord::Migration[6.1]
  def change
    create_table :spices do |t|
      t.string :name
      t.string :quantity
      t.integer :type
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
