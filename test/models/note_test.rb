require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "initial note" do
    assert_equal "Created", @job.notes.first.content
  end

  test "applied with job status updated" do
    create(:applied_note, job: @job )
    assert_equal 'applied', @job.status
  end

  test "archived with job status updated" do
    create(:archived_note, job: @job )
    assert_equal 'archived', @job.status
  end

  test "interviewed with job status updated" do
    create(:interviewed_note, job: @job )
    assert_equal 'interviewed', @job.status
  end

  test "tested with job status updated" do
    create(:tested_note, job: @job )
    assert_equal 'tested', @job.status
  end

  test "accepted with job status updated" do
    create(:accepted_note, job: @job )
    assert_equal 'accepted', @job.status
  end
end
