class ChangeColumnNullOnArrangement < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jobs, :arrangement, true
    change_column_default :jobs, :arrangement, nil
  end
end
