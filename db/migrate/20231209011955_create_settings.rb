class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.references :user
      t.integer :days_to_auto_archive, default: 21, null: false

      t.timestamps
    end
  end
end
