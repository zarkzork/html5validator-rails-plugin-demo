require 'test_helper'

class RegistrationInformationsControllerTest < ActionController::TestCase
  setup do
    @registration_information = registration_informations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registration_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration_information" do
    assert_difference('RegistrationInformation.count') do
      post :create, :registration_information => @registration_information.attributes
    end

    assert_redirected_to registration_information_path(assigns(:registration_information))
  end

  test "should show registration_information" do
    get :show, :id => @registration_information.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @registration_information.to_param
    assert_response :success
  end

  test "should update registration_information" do
    put :update, :id => @registration_information.to_param, :registration_information => @registration_information.attributes
    assert_redirected_to registration_information_path(assigns(:registration_information))
  end

  test "should destroy registration_information" do
    assert_difference('RegistrationInformation.count', -1) do
      delete :destroy, :id => @registration_information.to_param
    end

    assert_redirected_to registration_informations_path
  end
end
