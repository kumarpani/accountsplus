require 'test_helper'

class PrintQuotationsControllerTest < ActionController::TestCase
  setup do
    @print_quotation = print_quotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:print_quotations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create print_quotation" do
    assert_difference('PrintQuotation.count') do
      post :create, print_quotation: {  }
    end

    assert_redirected_to print_quotation_path(assigns(:print_quotation))
  end

  test "should show print_quotation" do
    get :show, id: @print_quotation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @print_quotation
    assert_response :success
  end

  test "should update print_quotation" do
    patch :update, id: @print_quotation, print_quotation: {  }
    assert_redirected_to print_quotation_path(assigns(:print_quotation))
  end

  test "should destroy print_quotation" do
    assert_difference('PrintQuotation.count', -1) do
      delete :destroy, id: @print_quotation
    end

    assert_redirected_to print_quotations_path
  end
end
