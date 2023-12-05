require "application_system_test_case"

class FeedbacksTest < ApplicationSystemTestCase
  setup do
    @feedback = create(:feedback)
    @user = @feedback.user
  end

  test "visiting the index" do
    visit feedbacks_url(as: @user)
    assert_selector "h1", text: "Feedback"
  end

  test "should create feedback" do
    visit feedbacks_url(as: @user)
    fill_in "feedback-content", with: @feedback.content
    click_on "Create Feedback"

    assert_text @feedback.content
    click_on "Jobs"
  end

  test "should destroy Feedback" do
    visit feedbacks_url(as: @user)
    accept_confirm do
      click_on "destroy-#{@feedback.id}"
    end
  end
end
