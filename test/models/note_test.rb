require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "initial note" do
    assert_equal "Created", @job.notes.first.content
  end

  test "setting initial job status" do
    assert_equal "created", @job.status
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

  test "deleting note and status reverting" do
    applied_note = create(:applied_note, job: @job )
    assert_equal "applied", @job.status
    interviewed_note = create(:interviewed_note, job: @job )
    assert_equal "interviewed", @job.status
    interviewed_note.destroy
    assert_equal "applied", @job.status
    applied_note.destroy
    assert_equal "created", @job.status
    @job.notes.destroy_all
    assert_equal "created", @job.status
  end

  test "days since status change only on some notes" do
    @job.notes.first.update(created_at: Time.now - 5.days)
    assert_equal 5, @job.days_since_status_change

    create(:general_note, job: @job)
    assert_equal 5, @job.days_since_status_change
    create(:emailed_note, job: @job)
    assert_equal 5, @job.days_since_status_change
    create(:applied_note, job: @job)
    assert_equal 0, @job.days_since_status_change

    @job.notes.last.destroy
    assert_equal 5, @job.days_since_status_change
  end
end
