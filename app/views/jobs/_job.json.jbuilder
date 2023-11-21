json.extract! job, :id, :entity, :title, :url, :description, :status, :order, :created_at, :updated_at
json.url job_url(job, format: :json)
