require 'test_helper'

class TourRequestsControllerTest < ActionController::TestCase
  setup do
    @tour_request = tour_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tour_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tour_request" do
    assert_difference('TourRequest.count') do
      post :create, tour_request: { additional_questions: @tour_request.additional_questions, amenities: @tour_request.amenities, email: @tour_request.email, first_name: @tour_request.first_name, ip_address: @tour_request.ip_address, last_name: @tour_request.last_name, phone_number: @tour_request.phone_number, preferred_tour_date: @tour_request.preferred_tour_date, salt: @tour_request.salt, security_hash: @tour_request.security_hash }
    end

    assert_redirected_to tour_request_path(assigns(:tour_request))
  end

  test "should show tour_request" do
    get :show, id: @tour_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tour_request
    assert_response :success
  end

  test "should update tour_request" do
    put :update, id: @tour_request, tour_request: { additional_questions: @tour_request.additional_questions, amenities: @tour_request.amenities, email: @tour_request.email, first_name: @tour_request.first_name, ip_address: @tour_request.ip_address, last_name: @tour_request.last_name, phone_number: @tour_request.phone_number, preferred_tour_date: @tour_request.preferred_tour_date, salt: @tour_request.salt, security_hash: @tour_request.security_hash }
    assert_redirected_to tour_request_path(assigns(:tour_request))
  end

  test "should destroy tour_request" do
    assert_difference('TourRequest.count', -1) do
      delete :destroy, id: @tour_request
    end

    assert_redirected_to tour_requests_path
  end
end
