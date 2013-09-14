require 'test_helper'

class ItemDetailsControllerTest < ActionController::TestCase
  setup do
    @item_detail = item_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_detail" do
    assert_difference('ItemDetail.count') do
      post :create, item_detail: { decimal: @item_detail.decimal, description: @item_detail.description, name: @item_detail.name, price: @item_detail.price }
    end

    assert_redirected_to item_detail_path(assigns(:item_detail))
  end

  test "should show item_detail" do
    get :show, id: @item_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_detail
    assert_response :success
  end

  test "should update item_detail" do
    patch :update, id: @item_detail, item_detail: { decimal: @item_detail.decimal, description: @item_detail.description, name: @item_detail.name, price: @item_detail.price }
    assert_redirected_to item_detail_path(assigns(:item_detail))
  end

  test "should destroy item_detail" do
    assert_difference('ItemDetail.count', -1) do
      delete :destroy, id: @item_detail
    end

    assert_redirected_to item_details_path
  end
end
