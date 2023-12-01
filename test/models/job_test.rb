require "test_helper"

class JobTest < ActiveSupport::TestCase
  test "ordering" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    assert_equal list[0], Job.rank(:order).first, "Jobs not being ordered last as they are created"
    assert_equal list[9], Job.rank(:order).last, "Jobs not being ordered last as they are created"
  end

  test "reorder up" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    list[2].reorder_up!
    assert_equal Job.rank(:order).second, list[2]
  end

  test "reorder down" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    list[2].reorder_down!
    assert_equal Job.rank(:order).fourth, list[2]
  end
end
