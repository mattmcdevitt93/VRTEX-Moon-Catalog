require 'test_helper'

class UniversesControllerTest < ActionController::TestCase
  setup do
    @universe = universes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:universes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create universe" do
    assert_difference('Universe.count') do
      post :create, universe: { constellation_id: @universe.constellation_id, constellation_name: @universe.constellation_name, region_id: @universe.region_id, region_name: @universe.region_name, system_id: @universe.system_id, system_name: @universe.system_name }
    end

    assert_redirected_to universe_path(assigns(:universe))
  end

  test "should show universe" do
    get :show, id: @universe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @universe
    assert_response :success
  end

  test "should update universe" do
    patch :update, id: @universe, universe: { constellation_id: @universe.constellation_id, constellation_name: @universe.constellation_name, region_id: @universe.region_id, region_name: @universe.region_name, system_id: @universe.system_id, system_name: @universe.system_name }
    assert_redirected_to universe_path(assigns(:universe))
  end

  test "should destroy universe" do
    assert_difference('Universe.count', -1) do
      delete :destroy, id: @universe
    end

    assert_redirected_to universes_path
  end
end
