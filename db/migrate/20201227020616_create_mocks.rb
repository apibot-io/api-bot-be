class CreateMocks < ActiveRecord::Migration[6.1]
  def change
    create_table :mocks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status_code, null: false
      t.string :content_type, null: false
      t.string :request_method, null: false
      t.string :route_path, null: false
      t.string :body_type
      t.text :body_content
      t.integer :mock_order, null: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :mocks, :mock_order, unique: true
  end
end
