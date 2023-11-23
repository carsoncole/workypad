require "test_helper"

class JobTest < ActiveSupport::TestCase
  test "ordering" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    assert_equal 1, list[0].order, "Jobs are not ordered as they are created"
    assert_equal 2, list[1].order
    assert_equal 4, list[3].order
  end

  test "reorder up" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    assert_equal 2, list[0].reorder_up!.order
    assert_equal 1, list[1].reload.order
    assert_equal 10, list[9].order
    assert_equal 10, list[9].reorder_up!.order, "order should not have increased beyond highester order"
  end

  test "reorder down" do
    user = create(:user)
    list = create_list(:job, 10, user: user)
    assert_equal 1, list[0].reorder_down!.order, "order should not have changed since it was lowest"
    assert_equal 1, list[1].reorder_down!.order
    assert_equal 2, list[0].reload.order
    assert_equal 4, list[3].order
  end
end
