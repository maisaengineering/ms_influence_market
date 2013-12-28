require 'test_helper'

class ResearchsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
