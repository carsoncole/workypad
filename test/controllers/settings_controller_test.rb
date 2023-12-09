require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = create(:user).setting
    @user = @setting.user
  end

  test "should create setting" do
    assert_difference("Setting.count") do
      post users_url, params: { user: { email: 'example@example.com', password: 'password' }}
    end

    assert_redirected_to root_url
  end

  test "should show setting" do
    get setting_url(@setting, as: @user)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting, as: @user)
    assert_response :success
  end

  test "should update setting" do
    patch setting_url(@setting, as: @user), params: { setting: { days_to_auto_archive: 25 }}
    assert_redirected_to setting_url(@setting)
  end
end
