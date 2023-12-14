require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test "application badge" do
    assert_not @user.application_badge?

    jobs = create_list(:job, 3, user: @user)

    note_0 = create(:note, job: jobs[0], category: 'applied')
    note_0.update(created_at: Time.now - 1.day)
    assert_not @user.application_badge?

    create(:note, job: jobs[1], category: 'applied')
    assert_not @user.application_badge?

    create(:note, job: jobs[2], category: 'applied')
    assert_not @user.application_badge?

    create(:note, job: jobs[0], category: 'applied')
    assert @user.application_badge?
  end

  test "fire badge" do
    assert_not @user.application_badge?

    jobs = create_list(:job, 3, user: @user)

    note_0 = create(:note, job: jobs[0], category: 'applied')
    note_0.update(created_at: Time.now - 1.day)
    assert_not @user.fire_badge?

    create_list(:note, 4, job: jobs[1], category: 'applied')
    assert @user.application_badge?
  end
end

