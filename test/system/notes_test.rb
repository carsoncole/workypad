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

  test "should create note" do
    visit job_notes_url(@job, as: @user)
    click_on "New note"

    fill_in "note-content", with: @note.content
    click_on "Create Note"
  end

  test "should destroy Note" do
    visit job_notes_url(@job, as: @user)
    click_on "destroy_#{@note.id}"

    assert_text "Note was successfully destroyed"
  end
end
