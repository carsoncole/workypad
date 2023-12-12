class AddEntityUrlToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :entity_url, :string
  end
end
