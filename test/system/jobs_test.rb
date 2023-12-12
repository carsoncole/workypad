require "application_system_test_case"

class JobsTest < ApplicationSystemTestCase
  setup do
    @job = create(:job, title: 'Asst to the Mgr')
    @user = @job.user
  end

  test "visiting the index" do
    visit jobs_url(as: @user)
  end

  test "should show job" do
    visit job_url(@job, as: @user)
    assert_text @job.entity.upcase
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
    sleep 0.25
    click_on "edit_job_#{@job.id}", match: :first

    fill_in "Description", with: @job.description
    fill_in "Entity", with: @job.entity
    # fill_in "Status", with: @job.status
    fill_in "Title", with: @job.title
    fill_in "Url", with: @job.url
    click_on "Update Job"
  end

  test "should archive Job" do
    visit job_url(@job, as: @user)

    assert_difference('Job.archived.count') do
      click_on "archive_job_#{@job.id}"
      sleep 1
    end
  end

  test "should destroy Job" do
    visit job_url(@job, as: @user)

    accept_confirm do
      click_on "delete_job_#{@job.id}", match: :first
    end
    assert_text "Job was successfully destroyed"
  end

  test "search" do
    job_2 = create(:job, user: @user, title: 'Tarmac agent')
    job_3 = create(:job, user: @user, entity: 'Double agent')
    visit jobs_url(as: @user)
    fill_in "search", with: "tarmac\n"
    assert_text "Tarmac agent"
    assert_no_text "Double agent"
    assert_no_text @job.title

    fill_in "search", with: "agent\n"
    assert_text "Tarmac agent"
    assert_text "DOUBLE AGENT"
    assert_no_text 'Asst to the Mgr'
  end

  test "application badge" do
    visit jobs_url(as: @user)
    assert_no_text "Congratulations! You've earned the Application Badge by submitting over 2 applications today."

    # 3 of applied! and applied notes
    create_list(:note, 2, job: @job, category: 'applied')
    @job.applied!

    visit jobs_url(as: @user)
    assert_text "Congratulations! You've earned the Application Badge by submitting over 2 applications today."


  end
end
