require "test_helper"

class SettingTest < ActiveSupport::TestCase
  test "initial creation on user" do
    user = create(:user)
    assert user.setting
  end
end
