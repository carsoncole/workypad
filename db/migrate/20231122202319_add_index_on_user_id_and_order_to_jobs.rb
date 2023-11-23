class AddIndexOnUserIdAndOrderToJobs < ActiveRecord::Migration[7.1]
  def change
    add_index :jobs, [:user_id, :order]
  end
end
