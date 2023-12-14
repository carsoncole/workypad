class AddAgencyNameToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :agency, :string
    remove_column :jobs, :is_agency, :string
  end
end
