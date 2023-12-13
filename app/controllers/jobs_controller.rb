#FIXME Show should not have expansion button
class JobsController < ApplicationController
  before_action :require_login
  before_action :set_job, only: %i[ show edit update destroy ]

  def dashboard
    @has_jobs = if current_user.jobs.any?
      true
    else
      false
    end
    @application_badge = true if current_user.notes.applied.where("notes.created_at > ?", Time.now - 24.hours).count > 2
  end

  def index
    # auto-archiving of notes
    current_user.create_setting unless current_user.setting
    current_user.jobs.where("status_updated_at < ?", Date.today - current_user.setting.days_to_auto_archive).update_all(status: 'archived')

    if params[:query].present?
      @jobs = Job.where("entity ILIKE ? OR title ILIKE ? OR description ILIKE ? OR primary_contact_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").order(:order)
    elsif params[:archived]
      @jobs = current_user.jobs.archived.order(:order)
    else
      @jobs = current_user.jobs.not_archived.rank(:order)
    end

    @application_badge = true if current_user.application_badge?
  end

  def show
    @notes = @job.notes.limit(3)
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = current_user.jobs.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:up]
      @job.reorder_up!
      redirect_to jobs_url
    elsif params[:down]
      @job.reorder_down!
      redirect_to jobs_url
    elsif params[:job][:position]
      @job.update order_position: params[:job][:position].to_i - 1
      redirect_to jobs_url
    elsif @job.update(job_params)

      if @job.status_previously_was == 'archived'
        redirect_to jobs_url(archived: true)
      else
        redirect_to jobs_url
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = current_user.jobs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:entity, :title, :url, :description, :status, :order, :source_id, :salary, :primary_contact_email, :primary_contact_phone, :primary_contact_name, :mode, :is_agency, :position, :arrangement, :entity_url, :listing )
    end
end
