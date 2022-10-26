require "test_helper"

class NewlinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newlink = newlinks(:one)
  end

  test "should get index" do
    get newlinks_url
    assert_response :success
  end

  test "should get new" do
    get new_newlink_url
    assert_response :success
  end

  test "should create newlink" do
    assert_difference("Newlink.count") do
      post newlinks_url, params: { newlink: { slug: @newlink.slug, url: @newlink.url } }
    end

    assert_redirected_to newlink_url(Newlink.last)
  end

  test "should show newlink" do
    get newlink_url(@newlink)
    assert_response :success
  end

  test "should get edit" do
    get edit_newlink_url(@newlink)
    assert_response :success
  end

  test "should update newlink" do
    patch newlink_url(@newlink), params: { newlink: { slug: @newlink.slug, url: @newlink.url } }
    assert_redirected_to newlink_url(@newlink)
  end

  test "should destroy newlink" do
    assert_difference("Newlink.count", -1) do
      delete newlink_url(@newlink)
    end

    assert_redirected_to newlinks_url
  end
end
