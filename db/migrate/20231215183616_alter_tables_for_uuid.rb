class AlterTablesForUuid < ActiveRecord::Migration[7.1]
  def up
    if foreign_key_exists?(:notes, :jobs)
      remove_foreign_key :notes, :jobs
    end

    change_table :jobs do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute "ALTER TABLE jobs ADD PRIMARY KEY (id);"

    change_table :notes do |t|
      t.remove :job_id
      t.rename :job_uuid, :job_id
    end

    execute "ALTER TABLE action_text_rich_texts DROP COLUMN record_id"
    execute "ALTER TABLE action_text_rich_texts RENAME COLUMN record_uuid TO record_id"

  end
end
