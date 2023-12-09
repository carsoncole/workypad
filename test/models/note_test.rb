require "test_helper"

class NoteTest < ActiveSupport::TestCase
  setup do
    @job = create(:job)
    @user = @job.user
  end

  test "creating note on application" do
    @job.applied!
    assert_equal 'applied', @job.notes.last.category
  end

  test "creating note on archiving" do
    @job.archived!
    assert_equal 'archive', @job.notes.last.category
  end
end
