class AddSalaryToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :salary, :string
  end
end
