class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :user
      t.string :entity
      t.string :title
      t.string :url
      t.text :description
      t.integer :status, default: 0
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
