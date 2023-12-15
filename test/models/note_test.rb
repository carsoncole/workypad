require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "initial note" do
    assert_equal "Created", @job.notes.first.content
  end

  test "creating note on application" do
    @job.applied!
    assert_equal 'applied', @job.notes.last.category
  end

  test "creating note on archiving" do
    @job.archived!
    assert_equal 'archive', @job.notes.last.category
  end

  test "applied at with category applied" do
    assert_not_equal 'applied', @job.status
    assert_nil @job.applied_at

    note = create(:note, job: @job, category: 'applied')
    assert_not_nil @job.reload.applied_at
  end

  test "archived at with category archive" do
    assert_not_equal 'archived', @job.status
    assert_nil @job.archived_at

    note = create(:note, job: @job, category: 'archive')
    assert_not_nil @job.reload.archived_at
  end
end
