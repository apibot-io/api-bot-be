class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.integer :physical_type, null: false
      t.integer :logical_type
      t.string :default_value

      t.references :resource, index: true, foreign_key: { on_delete: :cascade }, type: :uuid
      t.timestamps
    end
  end
end
