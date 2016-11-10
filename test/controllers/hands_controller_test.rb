require 'test_helper'

class HandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hands_index_url
    assert_response :success
  end

  test "should get show" do
    get hands_show_url
    assert_response :success
  end

  test "should get new" do
    get hands_new_url
    assert_response :success
  end

  test "should get create" do
    get hands_create_url
    assert_response :success
  end

  test "should get delete" do
    get hands_delete_url
    assert_response :success
  end

end
