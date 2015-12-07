require 'test_helper'

class OffhandsControllerTest < ActionController::TestCase
  setup do
    @offhand = offhands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offhands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offhand" do
    assert_difference('Offhand.count') do
      post :create, offhand: { armor: @offhand.armor, context: @offhand.context, itemLevel: @offhand.itemLevel, name: @offhand.name, quality: @offhand.quality }
    end

    assert_redirected_to offhand_path(assigns(:offhand))
  end

  test "should show offhand" do
    get :show, id: @offhand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offhand
    assert_response :success
  end

  test "should update offhand" do
    patch :update, id: @offhand, offhand: { armor: @offhand.armor, context: @offhand.context, itemLevel: @offhand.itemLevel, name: @offhand.name, quality: @offhand.quality }
    assert_redirected_to offhand_path(assigns(:offhand))
  end

  test "should destroy offhand" do
    assert_difference('Offhand.count', -1) do
      delete :destroy, id: @offhand
    end

    assert_redirected_to offhands_path
  end
end
