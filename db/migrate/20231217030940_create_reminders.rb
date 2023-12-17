class CreateReminders < ActiveRecord::Migration[7.1]
  def change
    create_table :reminders do |t|
      t.uuid :job_id
      t.datetime :remind_at
      t.integer :way, null: false

      t.timestamps
    end
  end
end
