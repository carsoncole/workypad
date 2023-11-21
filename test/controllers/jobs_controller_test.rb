require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "should get index" do
    get jobs_url(as: @user)
    assert_response :success
  end

  test "should get new" do
    get new_job_url(as: @user)
    assert_response :success
  end

  test "should create job" do
    assert_difference("Job.count") do
      post jobs_url(as: @user), params: { job: { description: @job.description, entity: @job.entity, order: @job.order, status: @job.status, title: @job.title, url: @job.url } }
    end

    assert_redirected_to job_url(Job.last)
  end

  test "should show job" do
    get job_url(@job, as: @user)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_url(@job, as: @user)
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job, as: @user), params: { job: { description: @job.description, entity: @job.entity, order: @job.order, status: @job.status, title: @job.title, url: @job.url } }
    assert_redirected_to job_url(@job)
  end

  test "should destroy job" do
    assert_difference("Job.count", -1) do
      delete job_url(@job, as: @user)
    end

    assert_redirected_to jobs_url
  end
end
