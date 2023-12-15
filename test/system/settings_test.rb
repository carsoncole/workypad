require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
  end

  test "visiting a setting" do
    visit setting_url(@user, as: @user)
    assert_selector "h1", text: "Settings"
  end

  test "should update Setting" do
    visit setting_url(@user.setting.id, as: @user)
    click_on "Edit", match: :first

    fill_in "Days to auto archive", with: 23
    click_on "Update"

    sleep 0.5
    assert_equal 23, @user.setting.reload.days_to_auto_archive
  end

  test "should destroy user and all their data" do
    visit setting_url(@user.setting.id, as: @user)
    accept_confirm do
      click_on "DESTROY ACCOUNT AND ALL DATA"
    end
    assert_selector "h1", text: "WorkyPad"
    assert_text "Your account has been deleted. To access Workypad, you can sign up again."
  end

end
