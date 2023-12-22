class AddPgTrim < ActiveRecord::Migration[7.1]
  def up
    enable_extension 'pg_trgm' unless extension_enabled?('pg_trgm')
    add_index :jobs, :entity, using: :gin, opclass: {entity: :gin_trgm_ops}
    add_index :jobs, :agency, using: :gin, opclass: {agency: :gin_trgm_ops}
    add_index :jobs, :title, using: :gin, opclass: {title: :gin_trgm_ops}
    add_index :jobs, :primary_contact_name, using: :gin, opclass: {primary_contact_name: :gin_trgm_ops}
  end

  def down
    remove_index :jobs, :entity
    remove_index :jobs, :agency
    remove_index :jobs, :title
    remove_index :jobs, :primary_contact_name
  end
end
