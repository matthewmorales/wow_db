require 'test_helper'

class MountsControllerTest < ActionController::TestCase
  setup do
    @mount = mounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mount" do
    assert_difference('Mount.count') do
      post :create, mount: { aquatic: @mount.aquatic, flying: @mount.flying, ground: @mount.ground, jumping: @mount.jumping, name: @mount.name }
    end

    assert_redirected_to mount_path(assigns(:mount))
  end

  test "should show mount" do
    get :show, id: @mount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mount
    assert_response :success
  end

  test "should update mount" do
    patch :update, id: @mount, mount: { aquatic: @mount.aquatic, flying: @mount.flying, ground: @mount.ground, jumping: @mount.jumping, name: @mount.name }
    assert_redirected_to mount_path(assigns(:mount))
  end

  test "should destroy mount" do
    assert_difference('Mount.count', -1) do
      delete :destroy, id: @mount
    end

    assert_redirected_to mounts_path
  end
end
