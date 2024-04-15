require "test_helper"

class ThesesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get theses_index_url
    assert_response :success
  end
end
