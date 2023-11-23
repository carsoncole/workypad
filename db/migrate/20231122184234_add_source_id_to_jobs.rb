class AddSourceIdToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :source_id, :integer
  end
end
