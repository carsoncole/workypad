class ChangeColumnAppliedOnToDatetime < ActiveRecord::Migration[7.1]
  def up
    change_column :jobs, :applied_on, :datetime
  end
end
