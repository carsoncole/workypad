require "test_helper"

class RemindersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = create(:job)
    @user = @job.user
    @reminder = build(:reminder, job: @job)
  end

  test "should create reminder" do
    assert_difference("Reminder.count") do
      post job_reminders_url(@job, as: @user), params: { reminder: { days_to_remind: @reminder.days_to_remind, way: @reminder.way } }
    end

    assert_redirected_to @job
  end

  test "should destroy reminder" do
    @reminder.save
    assert_difference("Reminder.count", -1) do
      delete job_reminder_url(@job, @reminder, as: @user)
    end

    assert_redirected_to job_url(@job)
  end
end
