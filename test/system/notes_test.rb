require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  setup do
    @note = create(:note)
    @job = @note.job
    @user = @job.user
  end

  test "visiting the index" do
    visit job_notes_url(@job, as: @user)
    assert_selector "h1", text: "Notes"
  end

  test "should create note on job show" do
    visit job_notes_url(@job, as: @user)

    fill_in "note-content", with: @note.content
    select('Interview', :from => 'category-select')
    click_on "Create Note"
  end


  test "should create note on jobs" do
    visit jobs_url(as: @user)
    find("#visibility_#{@job.id}").click
    click_on "new_job_note_#{@job.id}", match: :first

    fill_in "note-content", with: @note.content
    select('Interview', :from => 'category-select')
    click_on "Create Note"
  end


  test "should destroy Note" do
    visit job_notes_url(@job, as: @user)
    content = @note.content
    assert_text content
    click_on "destroy_#{@note.id}"
    assert_no_text content
  end
end
