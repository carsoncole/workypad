require "test_helper"

class FeedbacksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @feedback = create(:feedback)
    @user = @feedback.user
  end

  test "should get index" do
    get feedbacks_url(as: @user)
    assert_response :success
  end

  test "should create feedback" do
    assert_difference("Feedback.count") do
      post feedbacks_url(as: @user, params: { feedback: { content: @feedback.content, status: @feedback.status, user_id: @feedback.user_id } })
    end

    assert_redirected_to feedbacks_url
  end

  # test "should destroy feedback" do
  #   assert_difference("Feedback.count", -1) do
  #     delete feedback_url(@feedback)
  #   end

  #   assert_redirected_to feedbacks_url
  # end
end
