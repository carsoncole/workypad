class RemoveColumnDefaultForJobStatuse < ActiveRecord::Migration[7.1]
  def change
    change_column_default :jobs, :status, from: 0, to: nil
  end
end
