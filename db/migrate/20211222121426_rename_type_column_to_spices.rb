class RenameTypeColumnToSpices < ActiveRecord::Migration[6.1]
  def change
    rename_column :spices, :type, :classification
  end
end
