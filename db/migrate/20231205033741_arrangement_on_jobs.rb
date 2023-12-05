class ArrangementOnJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :arrangement, :integer, null: false, default: 1
  end
end
