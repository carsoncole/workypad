class AddUserIdToSources < ActiveRecord::Migration[7.1]
  def change
    add_column :sources, :user_id, :bigint
  end
end
