require "application_system_test_case"

class PublicTest < ApplicationSystemTestCase

  test "visiting the index" do
    visit root_url
    assert_text "Simplified Job Search Tracking"
  end

end
