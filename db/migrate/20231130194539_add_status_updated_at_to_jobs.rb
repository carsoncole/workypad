class AddStatusUpdatedAtToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :status_updated_at, :datetime
  end
end
