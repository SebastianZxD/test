require "application_system_test_case"

class NewlinksTest < ApplicationSystemTestCase
  setup do
    @newlink = newlinks(:one)
  end

  test "visiting the index" do
    visit newlinks_url
    assert_selector "h1", text: "Newlinks"
  end

  test "should create newlink" do
    visit newlinks_url
    click_on "New newlink"

    fill_in "Slug", with: @newlink.slug
    fill_in "Url", with: @newlink.url
    click_on "Create Newlink"

    assert_text "Newlink was successfully created"
    click_on "Back"
  end

  test "should update Newlink" do
    visit newlink_url(@newlink)
    click_on "Edit this newlink", match: :first

    fill_in "Slug", with: @newlink.slug
    fill_in "Url", with: @newlink.url
    click_on "Update Newlink"

    assert_text "Newlink was successfully updated"
    click_on "Back"
  end

  test "should destroy Newlink" do
    visit newlink_url(@newlink)
    click_on "Destroy this newlink", match: :first

    assert_text "Newlink was successfully destroyed"
  end
end
