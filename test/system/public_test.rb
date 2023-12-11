require "application_system_test_case"

class PublicTest < ApplicationSystemTestCase

  test "visiting the index" do
    visit root_url
    assert_text "Simplified Job Search Tracking"
  end

  test "visiting pricing" do
    visit pricing_url
    assert_text "Pricing"
  end

end
