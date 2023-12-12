require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @job = create(:job, status: 'applied')
    @user = @job.user
  end

  test "application badge" do
    visit root_url(as: @user)
    assert_no_text "Congratulations! You've earned the Application Badge by submitting over 2 applications today."

    create_list(:job, 2, user: @user, status: 'applied')
    visit root_url(as: @user)
    assert_text "Congratulations! You've earned the Application Badge by submitting over 2 applications today."
  end
end
