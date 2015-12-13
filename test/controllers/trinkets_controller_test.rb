require 'test_helper'

class TrinketsControllerTest < ActionController::TestCase
  setup do
    @trinket = trinkets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trinkets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trinket" do
    assert_difference('Trinket.count') do
      post :create, trinket: { armor: @trinket.armor, context: @trinket.context, icon: @trinket.icon, itemLevel: @trinket.itemLevel, name: @trinket.name, quality: @trinket.quality }
    end

    assert_redirected_to trinket_path(assigns(:trinket))
  end

  test "should show trinket" do
    get :show, id: @trinket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trinket
    assert_response :success
  end

  test "should update trinket" do
    patch :update, id: @trinket, trinket: { armor: @trinket.armor, context: @trinket.context, icon: @trinket.icon, itemLevel: @trinket.itemLevel, name: @trinket.name, quality: @trinket.quality }
    assert_redirected_to trinket_path(assigns(:trinket))
  end

  test "should destroy trinket" do
    assert_difference('Trinket.count', -1) do
      delete :destroy, id: @trinket
    end

    assert_redirected_to trinkets_path
  end
end
