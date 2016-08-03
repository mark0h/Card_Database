require 'test_helper'

class TraitControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
