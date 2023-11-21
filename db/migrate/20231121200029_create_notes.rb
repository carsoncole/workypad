class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :job, null: false, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
