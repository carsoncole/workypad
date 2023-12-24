class AddIsFavoriteToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :is_favorite, :boolean
  end
end
