class AddModeToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :mode, :integer
  end
end
