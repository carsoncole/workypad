class AddPgcryptoAndUuidToJobs < ActiveRecord::Migration[7.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end
