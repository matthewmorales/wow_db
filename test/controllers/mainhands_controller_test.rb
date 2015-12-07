require 'test_helper'

class MainhandsControllerTest < ActionController::TestCase
  setup do
    @mainhand = mainhands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mainhands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mainhand" do
    assert_difference('Mainhand.count') do
      post :create, mainhand: { context: @mainhand.context, dps: @mainhand.dps, itemLevel: @mainhand.itemLevel, name: @mainhand.name, quality: @mainhand.quality }
    end

    assert_redirected_to mainhand_path(assigns(:mainhand))
  end

  test "should show mainhand" do
    get :show, id: @mainhand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mainhand
    assert_response :success
  end

  test "should update mainhand" do
    patch :update, id: @mainhand, mainhand: { context: @mainhand.context, dps: @mainhand.dps, itemLevel: @mainhand.itemLevel, name: @mainhand.name, quality: @mainhand.quality }
    assert_redirected_to mainhand_path(assigns(:mainhand))
  end

  test "should destroy mainhand" do
    assert_difference('Mainhand.count', -1) do
      delete :destroy, id: @mainhand
    end

    assert_redirected_to mainhands_path
  end
end
