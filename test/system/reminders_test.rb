require "application_system_test_case"

class RemindersTest < ApplicationSystemTestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "should create reminder" do
    visit job_url(@job, as: @user)
    click_button "Remind me"

    within("#job_#{@job.id}_not_due") do
      assert_text "Follow up call in 7 days"
    end

    visit jobs_url(as: @user)
    within("#job_#{@job.id}_not_due") do
      assert_text "Follow up call in 7 days"
    end
  end

  test "should show due reminder" do
    reminder = create(:reminder, job: @job)
    reminder.update(remind_at: Time.now - 2.days)

    visit job_url(@job, as: @user)
    within("#job_#{@job.id}_is_due") do
      assert_text "Follow up call"
    end

    visit jobs_url(as: @user)
    within("#job_#{@job.id}_is_due") do
      assert_text "Follow up call"
    end
  end

  test "should destroy not due reminder" do
    reminder = create(:reminder, job: @job)
    visit jobs_url(@reminder, as: @user)

    within("#job_#{@job.id}_not_due") do
      click_on "job_#{@job.id}_not_due_delete"
    end
    assert_no_text "Follow up call in 7 days"
  end

  test "should destroy due reminder" do
    reminder = create(:reminder, job: @job)
    reminder.update(remind_at: Time.now - 2.days)
    visit jobs_url(@reminder, as: @user)

    within("#job_#{@job.id}_is_due") do
      assert_text "Follow up call"
    end
    within("#job_#{@job.id}_is_due") do
      click_on "job_#{@job.id}_due_delete"
    end
    assert_no_selector "#job_#{@job.id}_is_due"
  end
end
