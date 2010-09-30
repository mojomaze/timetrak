require 'test_helper'

class ListValuesControllerTest < ActionController::TestCase
  setup do
    @list_value = list_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:list_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create list_value" do
    assert_difference('ListValue.count') do
      post :create, :list_value => @list_value.attributes
    end

    assert_redirected_to list_value_path(assigns(:list_value))
  end

  test "should show list_value" do
    get :show, :id => @list_value.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @list_value.to_param
    assert_response :success
  end

  test "should update list_value" do
    put :update, :id => @list_value.to_param, :list_value => @list_value.attributes
    assert_redirected_to list_value_path(assigns(:list_value))
  end

  test "should destroy list_value" do
    assert_difference('ListValue.count', -1) do
      delete :destroy, :id => @list_value.to_param
    end

    assert_redirected_to list_values_path
  end
end
