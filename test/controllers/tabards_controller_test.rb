require 'test_helper'

class TabardsControllerTest < ActionController::TestCase
  setup do
    @tabard = tabards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tabards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tabard" do
    assert_difference('Tabard.count') do
      post :create, tabard: { armor: @tabard.armor, context: @tabard.context, itemLevel: @tabard.itemLevel, name: @tabard.name, quality: @tabard.quality }
    end

    assert_redirected_to tabard_path(assigns(:tabard))
  end

  test "should show tabard" do
    get :show, id: @tabard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tabard
    assert_response :success
  end

  test "should update tabard" do
    patch :update, id: @tabard, tabard: { armor: @tabard.armor, context: @tabard.context, itemLevel: @tabard.itemLevel, name: @tabard.name, quality: @tabard.quality }
    assert_redirected_to tabard_path(assigns(:tabard))
  end

  test "should destroy tabard" do
    assert_difference('Tabard.count', -1) do
      delete :destroy, id: @tabard
    end

    assert_redirected_to tabards_path
  end
end
