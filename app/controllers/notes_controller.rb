class NotesController < ApplicationController
  before_action :require_login
  before_action :set_job
  before_action :set_note, only: %i[ edit update destroy ]

  def index
    @notes = @job.notes.order(created_at: :desc)
    @note = @job.notes.new
  end

  def edit
  end

  def create
    @note = @job.notes.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to job_notes_url(@job) }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to job_notes_url(@job), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy!

    respond_to do |format|
      format.html { redirect_to job_notes_url(@job), notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_note
      @note = @job.notes.find(params[:id])
    end

    def set_job
      @job = current_user.jobs.find(params[:job_id])
    end

    def note_params
      params.require(:note).permit(:job_id, :content, :category, :created_at)
    end
end
