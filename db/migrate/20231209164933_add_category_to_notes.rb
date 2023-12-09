class AddCategoryToNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :notes, :category, :integer
  end
end
