class AddIndexToNameResource < ActiveRecord::Migration[6.1]
  def change
    add_index :resources, :name, unique: true
    remove_column :resources, :integer_id, :integer
  end
end
