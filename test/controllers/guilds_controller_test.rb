require 'test_helper'

class GuildsControllerTest < ActionController::TestCase
  setup do
    @guild = guilds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:guilds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create guild" do
    assert_difference('Guild.count') do
      post :create, guild: { achievement_points: @guild.achievement_points, battlegroup: @guild.battlegroup, members: @guild.members, name: @guild.name, realm: @guild.realm }
    end

    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should show guild" do
    get :show, id: @guild
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @guild
    assert_response :success
  end

  test "should update guild" do
    patch :update, id: @guild, guild: { achievement_points: @guild.achievement_points, battlegroup: @guild.battlegroup, members: @guild.members, name: @guild.name, realm: @guild.realm }
    assert_redirected_to guild_path(assigns(:guild))
  end

  test "should destroy guild" do
    assert_difference('Guild.count', -1) do
      delete :destroy, id: @guild
    end

    assert_redirected_to guilds_path
  end
end
