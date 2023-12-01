class AddDateAppliedToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :applied_on, :date
  end
end
