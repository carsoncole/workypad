require "test_helper"

class ReminderTest < ActiveSupport::TestCase
  test "setting remind at" do
    reminder = create(:reminder)
    assert_equal 7, ((reminder.remind_at - Time.now).to_f/1.day).ceil
  end

  test "only 1 reminder per job" do
    job = create(:job)
    assert create(:reminder, job: job, days_to_remind: 7)
    assert_not build(:reminder, job: job, days_to_remind: 7).valid?, "only 1 reminder per job"
    assert create(:reminder)
  end
end
