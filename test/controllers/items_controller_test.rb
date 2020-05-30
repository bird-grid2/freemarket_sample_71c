require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  test "should get show" do
    get items_show_url

  test "should get index" do
    get items_index_url

    assert_response :success
  end

end
