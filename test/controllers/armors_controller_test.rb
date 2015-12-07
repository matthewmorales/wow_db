require 'test_helper'

class ArmorsControllerTest < ActionController::TestCase
  setup do
    @armor = armors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:armors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create armor" do
    assert_difference('Armor.count') do
      post :create, armor: { armor: @armor.armor, level: @armor.level, name: @armor.name, quality: @armor.quality }
    end

    assert_redirected_to armor_path(assigns(:armor))
  end

  test "should show armor" do
    get :show, id: @armor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @armor
    assert_response :success
  end

  test "should update armor" do
    patch :update, id: @armor, armor: { armor: @armor.armor, level: @armor.level, name: @armor.name, quality: @armor.quality }
    assert_redirected_to armor_path(assigns(:armor))
  end

  test "should destroy armor" do
    assert_difference('Armor.count', -1) do
      delete :destroy, id: @armor
    end

    assert_redirected_to armors_path
  end
end
