class Note < ApplicationRecord
  belongs_to :job

  enum category: { applied: 1, interview: 2, test: 3, call: 4, archive: 5, general: 99 }, _default: "general"

  after_create :update_job_applied_status!, if: ->(obj){ obj.applied? }

  after_create :update_job_archived_status!, if: ->(obj){ obj.archive? }

  private

  def update_job_applied_status!
    job.update(applied_at: Time.now)
  end

  def update_job_archived_status!
    job.update(archived_at: Time.now)
  end

end
