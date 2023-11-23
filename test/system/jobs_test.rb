require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "visiting the index" do
    visit jobs_url(as: @user)
  end

  test "should create job" do
    visit jobs_url(as: @user)
    click_on "New job"

    fill_in "Description", with: @job.description
    fill_in "Entity", with: @job.entity
    # fill_in "Status", with: @job.status
    fill_in "Title", with: @job.title
    fill_in "Url", with: @job.url
    click_on "Create Job"

    assert_text "Job was successfully created"
    click_on "Back"
  end

  test "should update Job" do
    visit job_url(@job, as: @user)
    click_on "Edit this job", match: :first

    fill_in "Description", with: @job.description
    fill_in "Entity", with: @job.entity
    # fill_in "Status", with: @job.status
    fill_in "Title", with: @job.title
    fill_in "Url", with: @job.url
    click_on "Update Job"

    assert_text "Job was successfully updated"
  end

  test "should destroy Job" do
    visit job_url(@job, as: @user)
    click_on "Destroy this job", match: :first

    assert_text "Job was successfully destroyed"
  end
end
