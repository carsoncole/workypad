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
    within("#job_#{@job.id}_status") do
      assert_text "RESEARCH"
    end
  end

  test "should create job" do
    visit jobs_url(as: @user)
    click_on "New job"

    fill_in "Entity", with: @job.entity
    select('Remote', :from => 'mode-select')
    select('Full time', :from => 'arrangement-select')
    fill_in "job[title]", with: @job.title
    fill_in "job[url]", with: @job.url
    click_on "Create Job"

    assert_text "Job was successfully created"
    within "#job-indicators" do
      assert_text "Full time"
      assert_text "Remote"
    end

    within "#job_#{@user.jobs.order(:created_at).last.id}_status" do
      assert_text "RESEARCH"
    end

    click_on "Back to jobs"
  end

  test "error message on creating a job" do
    visit jobs_url(as: @user)
    click_on "New job"
    click_on "Create Job"

    assert_text "Specify at least one entity or agency"
    fill_in "Entity", with: @job.entity
    click_on "Create Job"
    assert_text "Title can't be blank"
    fill_in "job[title]", with: @job.title
    click_on "Create Job"
    assert_text "Job was successfully created"
  end


  test "should update Job" do
    visit job_url(@job, as: @user)
    sleep 0.25
    click_on "edit_job_#{@job.id}", match: :first

    fill_in "Agency", with: "Some agency"
    click_on "Update Job"

    within "#job-indicators" do
      assert_text "Agency"
    end

  end

  test "should archive Job" do
    visit job_url(@job, as: @user)

    assert_difference('Job.archived.count') do
      click_on "archive_job_#{@job.id}", match: :first
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
    assert_no_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."

    # 3 of applied! and applied notes
    create_list(:note, 3, job: @job, category: 'applied')

    visit jobs_url(as: @user)
    assert_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."
  end

  test "status indicators" do
    visit job_url(@job, as: @user)
    within "#statuses" do
      assert_text "Created"
      assert_no_text "Applied"
      assert_no_text "Archived"
    end

    click_on "new_job_note_#{@job.id}", match: :first
    select('Applied', :from => 'category-select')
    click_on "Create Note"

    click_on "Back to Job"
    within "#statuses" do
      assert_text "Applied"
    end

    click_on "new_job_note_#{@job.id}", match: :first
    select('Archived', :from => 'category-select')
    click_on "Create Note"
    click_on "Back to Job"

    within "#statuses" do
      assert_text "Archived"
      assert_text "Applied"
      assert_text "Created"
    end

    click_on "new_job_note_#{@job.id}", match: :first
    select('Applied', :from => 'category-select')
    click_on "Create Note"
    click_on "Back to Job"
    within "#statuses" do
      assert_text "Applied", count: 2
    end

    click_on "archive_job_#{@job.id}", match: :first
    within "#statuses" do
      assert_text "Applied", count: 2
    end
    click_on "new_job_note_#{@job.id}", match: :first
    assert_selector ".category", text: "Archived", count: 2
  end
end
