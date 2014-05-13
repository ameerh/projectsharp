require 'test_helper'

class PitchersControllerTest < ActionController::TestCase
  setup do
    @pitcher = pitchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pitchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pitcher" do
    assert_difference('Pitcher.count') do
      post :create, pitcher: {  }
    end

    assert_redirected_to pitcher_path(assigns(:pitcher))
  end

  test "should show pitcher" do
    get :show, id: @pitcher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pitcher
    assert_response :success
  end

  test "should update pitcher" do
    patch :update, id: @pitcher, pitcher: {  }
    assert_redirected_to pitcher_path(assigns(:pitcher))
  end

  test "should destroy pitcher" do
    assert_difference('Pitcher.count', -1) do
      delete :destroy, id: @pitcher
    end

    assert_redirected_to pitchers_path
  end
end
