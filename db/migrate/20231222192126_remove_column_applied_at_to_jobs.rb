class RemoveColumnAppliedAtToJobs < ActiveRecord::Migration[7.1]
  def change
    remove_column :jobs, :applied_at, :datetime
    remove_column :jobs, :archived_at, :datetie
  end
end
