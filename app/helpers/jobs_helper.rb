module JobsHelper

  def days_since_status_change(job)
    if job.status_updated_at.present?
      (Time.now.to_date - job.status_updated_at.to_date).ceil.to_i
    else
      0
    end
  end

end
