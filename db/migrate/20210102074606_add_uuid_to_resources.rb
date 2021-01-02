class AddUuidToResources < ActiveRecord::Migration[6.1]
  def up
    add_column :resources, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :resources, :id, :integer_id
    rename_column :resources, :uuid, :id
    execute "ALTER TABLE resources drop constraint resources_pkey;"
    execute "ALTER TABLE resources ADD PRIMARY KEY (id);"

    # Optinally you remove auto-incremented
    # default value for integer_id column
    execute "ALTER TABLE ONLY resources ALTER COLUMN integer_id DROP DEFAULT;"
    change_column_null :resources, :integer_id, true
    execute "DROP SEQUENCE IF EXISTS resources_id_seq"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
