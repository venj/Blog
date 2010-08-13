require 'test_helper'

class TaggingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taggings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tagging" do
    assert_difference('Tagging.count') do
      post :create, :tagging => { }
    end

    assert_redirected_to tagging_path(assigns(:tagging))
  end

  test "should show tagging" do
    get :show, :id => taggings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => taggings(:one).to_param
    assert_response :success
  end

  test "should update tagging" do
    put :update, :id => taggings(:one).to_param, :tagging => { }
    assert_redirected_to tagging_path(assigns(:tagging))
  end

  test "should destroy tagging" do
    assert_difference('Tagging.count', -1) do
      delete :destroy, :id => taggings(:one).to_param
    end

    assert_redirected_to taggings_path
  end
end
