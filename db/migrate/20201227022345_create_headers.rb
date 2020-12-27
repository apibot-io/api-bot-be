class CreateHeaders < ActiveRecord::Migration[6.1]
  def change
    create_table :headers do |t|
      t.string :name, null: false
      t.string :value, null: false
      t.references :mock, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
