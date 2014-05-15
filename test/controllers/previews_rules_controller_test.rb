require 'test_helper'

class PreviewsRulesControllerTest < ActionController::TestCase
  setup do
    @previews_rule = previews_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:previews_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create previews_rule" do
    assert_difference('PreviewsRule.count') do
      post :create, previews_rule: {  }
    end

    assert_redirected_to previews_rule_path(assigns(:previews_rule))
  end

  test "should show previews_rule" do
    get :show, id: @previews_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @previews_rule
    assert_response :success
  end

  test "should update previews_rule" do
    patch :update, id: @previews_rule, previews_rule: {  }
    assert_redirected_to previews_rule_path(assigns(:previews_rule))
  end

  test "should destroy previews_rule" do
    assert_difference('PreviewsRule.count', -1) do
      delete :destroy, id: @previews_rule
    end

    assert_redirected_to previews_rules_path
  end
end
