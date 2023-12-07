class AddArchivedAtToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :archived_at, :datetime
    rename_column :jobs, :applied_on, :applied_at
  end
end
