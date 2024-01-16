class Note < ApplicationRecord
  belongs_to :job

  enum category: { researched: 0, applied: 1, interviewed: 2, tested: 3, called: 4, emailed: 5, messaged: 6, accepted: 8, archived: 10, created: 100, general: 99 }, _default: "general"

  scope :status_update, -> { where(category: ['applied', 'interviewed', 'tested', 'archived', 'researched', 'created']) }

  after_save :update_applied_status!, if: -> (obj){ obj.applied? }
  after_save :update_interviewed_status!, if: -> (obj){ obj.interviewed? }
  after_save :update_archived_status!, if: -> (obj){ obj.archived? }
  after_save :update_tested_status!, if: -> (obj){ obj.tested? }
  after_save :update_accepted_status!, if: -> (obj){ obj.accepted? }

  after_destroy :reset_status!, if: -> (obj){ ['applied', 'interviewed', 'tested', 'archived', 'created', 'researched'].include? obj.category }

  private

  def update_applied_status!
    job.update(status: 'applied', status_updated_at: Time.now, updated_by_note: true)
  end

  def update_interviewed_status!
    job.update(status: 'interviewed', status_updated_at: Time.now, updated_by_note: true)
  end

  def update_archived_status!
    job.update(status: 'archived', status_updated_at: Time.now, updated_by_note: true)
  end

  def update_tested_status!
    job.tested!
  end

  def update_accepted_status!
    job.accepted!
  end

  def reset_status!
    if job.last_note_status
      job.update(status: job.last_note_status.category)
    else
      job.research!
    end
  end
end
