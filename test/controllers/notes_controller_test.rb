require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @job = create(:job, user: @user)
    @note = create(:note, job: @job)
  end

  test "should get index" do
    get job_notes_url(@job, as: @user)
    assert_response :success
  end

  test "should get new" do
    get new_job_note_url(@job, as: @user)
    assert_response :success
  end

  test "should create note" do
    assert_difference("Note.count") do
      post job_notes_url(@job, as: @user), params: { note: { content: @note.content, job_id: @note.job_id } }
    end

    assert_redirected_to job_notes_url(@job)
  end

  test "should show note" do
    get job_note_url(@job, @note, as: @user)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_note_url(@job, @note, as: @user)
    assert_response :success
  end

  test "should update note" do
    patch job_note_url(@job, @note, as: @user), params: { note: { content: @note.content, job_id: @note.job_id } }
    assert_redirected_to job_note_url(@job, @note)
  end

  test "should destroy note" do
    assert_difference("Note.count", -1) do
      delete job_note_url(@job, @note, as: @user)
    end

    assert_redirected_to job_notes_url(@job)
  end
end
