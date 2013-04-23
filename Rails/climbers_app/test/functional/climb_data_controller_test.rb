require 'test_helper'

class ClimbDataControllerTest < ActionController::TestCase
  setup do
    @climb_datum = climb_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:climb_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create climb_datum" do
    assert_difference('ClimbDatum.count') do
      post :create, climb_datum: { area: @climb_datum.area, climb_type: @climb_datum.climb_type, description: @climb_datum.description, height: @climb_datum.height, image_url: @climb_datum.image_url, latitude: @climb_datum.latitude, location_name: @climb_datum.location_name, longitude: @climb_datum.longitude, parking_lat: @climb_datum.parking_lat, parking_long: @climb_datum.parking_long, rock_name: @climb_datum.rock_name, route_name: @climb_datum.route_name, skill_level: @climb_datum.skill_level, state: @climb_datum.state }
    end

    assert_redirected_to climb_datum_path(assigns(:climb_datum))
  end

  test "should show climb_datum" do
    get :show, id: @climb_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @climb_datum
    assert_response :success
  end

  test "should update climb_datum" do
    put :update, id: @climb_datum, climb_datum: { area: @climb_datum.area, climb_type: @climb_datum.climb_type, description: @climb_datum.description, height: @climb_datum.height, image_url: @climb_datum.image_url, latitude: @climb_datum.latitude, location_name: @climb_datum.location_name, longitude: @climb_datum.longitude, parking_lat: @climb_datum.parking_lat, parking_long: @climb_datum.parking_long, rock_name: @climb_datum.rock_name, route_name: @climb_datum.route_name, skill_level: @climb_datum.skill_level, state: @climb_datum.state }
    assert_redirected_to climb_datum_path(assigns(:climb_datum))
  end

  test "should destroy climb_datum" do
    assert_difference('ClimbDatum.count', -1) do
      delete :destroy, id: @climb_datum
    end

    assert_redirected_to climb_data_path
  end
end
