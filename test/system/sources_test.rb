require "application_system_test_case"

class SourcesTest < ApplicationSystemTestCase
  setup do
    @source = sources(:one)
  end

  test "visiting the index" do
    visit sources_url
    assert_selector "h1", text: "Sources"
  end

  test "should create source" do
    visit sources_url
    click_on "New source"

    fill_in "Name", with: @source.name
    click_on "Create Source"

    assert_text "Source was successfully created"
    click_on "Back"
  end

  test "should update Source" do
    visit source_url(@source)
    click_on "Edit this source", match: :first

    fill_in "Name", with: @source.name
    click_on "Update Source"

    assert_text "Source was successfully updated"
    click_on "Back"
  end

  test "should destroy Source" do
    visit source_url(@source)
    click_on "Destroy this source", match: :first

    assert_text "Source was successfully destroyed"
  end
end
