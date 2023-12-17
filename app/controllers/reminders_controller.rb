class RemindersController < ApplicationController
  before_action :require_login
  before_action :set_job, only: %i[ create destroy ]
  before_action :set_reminder, only: %i[ destroy ]

  def create
    @reminder = @job.reminders.new(reminder_params)

    if @reminder.save
      redirect_to @job
    else
      puts "*"*80
      redirect_to @job, status: 400
    end
  end

  def destroy
    @reminder.destroy!
    redirect_to @job
  end

  private
    def set_reminder
      @reminder = @job.reminders.find(params[:id])
    end

    def set_job
      @job = current_user.jobs.find(params[:job_id])
    end

    def reminder_params
      params.require(:reminder).permit(:remind_at, :way, :days_to_remind, :job_id)
    end
end
