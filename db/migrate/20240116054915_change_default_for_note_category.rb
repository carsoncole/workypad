class ChangeDefaultForNoteCategory < ActiveRecord::Migration[7.1]
  def change
    change_column_default :notes, :category, from: 0, to: 100
  end
end
