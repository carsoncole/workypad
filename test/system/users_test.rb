require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @job = create(:job)
    create(:applied_note, job: @job)
    @user = @job.user
  end

  test "application badge" do
    visit root_url(as: @user)
    assert_no_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."

    jobs = create_list(:job, 2, user: @user)
    jobs.each { |j| create(:applied_note, job: j) }
    visit root_url(as: @user)
    assert_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."
  end

  test "fire badge" do
    visit root_url(as: @user)
    assert_no_text "You're fire! You submitted over 4 applications today."

    jobs = create_list(:job, 2, user: @user)
    jobs.each { |j| create(:applied_note, job: j) }
    visit root_url(as: @user)
    assert_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."

    jobs = create_list(:job, 3, user: @user)
    jobs.each { |j| create(:applied_note, job: j) }
    visit root_url(as: @user)
    assert_no_text "Congratulations! You earned the Application Badge by submitting over 2 applications today."
    assert_text "You're fire! You submitted over 4 applications today."

    assert "#fire_badge"
  end
end
