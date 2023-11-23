class AddPrimaryContactNameToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :primary_contact_name, :string
    add_column :jobs, :primary_contact_email, :string
    add_column :jobs, :primary_contact_phone, :string
  end
end
