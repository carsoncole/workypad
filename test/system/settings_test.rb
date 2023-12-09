require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:one)
  end

  test "visiting the index" do
    visit settings_url
    assert_selector "h1", text: "Settings"
  end

  test "should create setting" do
    visit settings_url
    click_on "New setting"

    fill_in "Days to auto archive", with: @setting.days_to_auto_archive
    click_on "Create Setting"

    assert_text "Setting was successfully created"
    click_on "Back"
  end

  test "should update Setting" do
    visit setting_url(@setting)
    click_on "Edit this setting", match: :first

    fill_in "Days to auto archive", with: @setting.days_to_auto_archive
    click_on "Update Setting"

    assert_text "Setting was successfully updated"
    click_on "Back"
  end

  test "should destroy Setting" do
    visit setting_url(@setting)
    click_on "Destroy this setting", match: :first

    assert_text "Setting was successfully destroyed"
  end
end
