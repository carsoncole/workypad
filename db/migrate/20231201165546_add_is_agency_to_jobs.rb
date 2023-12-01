class AddIsAgencyToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :is_agency, :boolean, default: false
  end
end
