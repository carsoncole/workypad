require "test_helper"

class JobTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test "ordering" do
    list = create_list(:job, 10, user: @user)
    assert_equal list[0], Job.rank(:order).first, "Jobs not being ordered last as they are created"
    assert_equal list[9], Job.rank(:order).last, "Jobs not being ordered last as they are created"
  end

  test "reorder up" do
    list = create_list(:job, 10, user: @user)
    list[2].reorder_up!
    assert_equal Job.rank(:order).second, list[2]
  end

  test "reorder down" do
    list = create_list(:job, 10, user: @user)
    list[2].reorder_down!
    assert_equal Job.rank(:order).fourth, list[2]
  end

  test "applied at with status applied" do
    job = create(:job, user: @user)
    assert_nil job.applied_at

    job.applied!
    assert_equal Date.today, job.reload.applied_at
  end

  test 'status updated at' do
    job = create(:job, user: @user)
    assert_not_nil job.status_updated_at

    job.test!
    assert job.saved_change_to_status_updated_at?
  end

  test 'archived at' do
    job = create(:job, user: @user)
    assert_nil job.archived_at

    job.archived!
    assert_equal Date.today, job.reload.archived_at
  end
end
