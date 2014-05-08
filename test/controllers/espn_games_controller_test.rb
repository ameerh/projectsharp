require 'test_helper'

class EspnGamesControllerTest < ActionController::TestCase
  setup do
    @espn_game = espn_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:espn_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create espn_game" do
    assert_difference('EspnGame.count') do
      post :create, espn_game: {  }
    end

    assert_redirected_to espn_game_path(assigns(:espn_game))
  end

  test "should show espn_game" do
    get :show, id: @espn_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @espn_game
    assert_response :success
  end

  test "should update espn_game" do
    patch :update, id: @espn_game, espn_game: {  }
    assert_redirected_to espn_game_path(assigns(:espn_game))
  end

  test "should destroy espn_game" do
    assert_difference('EspnGame.count', -1) do
      delete :destroy, id: @espn_game
    end

    assert_redirected_to espn_games_path
  end
end
