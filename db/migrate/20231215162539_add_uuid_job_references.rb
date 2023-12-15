class AddUuidJobReferences < ActiveRecord::Migration[7.1]
  def up

    add_column :jobs, :uuid, :uuid, default: "gen_random_uuid()", null: false

    unless column_exists? :jobs, :old_id
      add_column :jobs, :old_id, :integer
    end

    unless column_exists? :notes, :old_job_id
      add_column :notes, :old_job_id, :integer
      add_column :notes, :job_uuid, :uuid
    end

    add_column :action_text_rich_texts, :record_uuid, :uuid
    add_column :action_text_rich_texts, :old_record_id, :integer

    Job.all.each do |job|
      job.update(old_id: job.id) unless job.old_id.present?
    end

    Note.all.each do |note|
      note.update(job_uuid: note.job.uuid)
      note.update(old_job_id: note.job_id) unless note.old_job_id.present?
    end

    all_listings = ActiveRecord::Base.connection.execute("Select * from action_text_rich_texts")
    all_listings.each do |l|
      job = Job.find(l['record_id'])
      ActiveRecord::Base.connection.execute("UPDATE action_text_rich_texts SET record_uuid = '#{job.uuid}' WHERE record_id = #{job.id}")
      ActiveRecord::Base.connection.execute("UPDATE action_text_rich_texts SET old_record_id = record_id WHERE record_id = #{job.id} AND old_record_id IS NULL")
    end
  end
end

