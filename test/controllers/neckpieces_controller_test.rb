require 'test_helper'

class NeckpiecesControllerTest < ActionController::TestCase
  setup do
    @neckpiece = neckpieces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:neckpieces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create neckpiece" do
    assert_difference('Neckpiece.count') do
      post :create, neckpiece: { armor: @neckpiece.armor, context: @neckpiece.context, icon: @neckpiece.icon, itemLevel: @neckpiece.itemLevel, name: @neckpiece.name, quality: @neckpiece.quality }
    end

    assert_redirected_to neckpiece_path(assigns(:neckpiece))
  end

  test "should show neckpiece" do
    get :show, id: @neckpiece
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @neckpiece
    assert_response :success
  end

  test "should update neckpiece" do
    patch :update, id: @neckpiece, neckpiece: { armor: @neckpiece.armor, context: @neckpiece.context, icon: @neckpiece.icon, itemLevel: @neckpiece.itemLevel, name: @neckpiece.name, quality: @neckpiece.quality }
    assert_redirected_to neckpiece_path(assigns(:neckpiece))
  end

  test "should destroy neckpiece" do
    assert_difference('Neckpiece.count', -1) do
      delete :destroy, id: @neckpiece
    end

    assert_redirected_to neckpieces_path
  end
end
