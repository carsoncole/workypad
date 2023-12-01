class RemoveDefaultOrderFromJobs < ActiveRecord::Migration[7.1]
  def change
    change_column_default :jobs, :order, from: 0, to: nil
  end
end
