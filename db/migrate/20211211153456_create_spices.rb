class CreateSpices < ActiveRecord::Migration[6.1]
  def change
    create_table :spices do |t|
      t.string :name, null: false
      t.string :quantity, null: false
      t.integer :type, null: false, default: 0
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
