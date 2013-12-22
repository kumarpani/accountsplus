require 'test_helper'

class IncomingServiceTaxesControllerTest < ActionController::TestCase
  setup do
    @incoming_service_tax = incoming_service_taxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incoming_service_taxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incoming_service_tax" do
    assert_difference('IncomingServiceTax.count') do
      post :create, incoming_service_tax: { description: @incoming_service_tax.description, event_total: @incoming_service_tax.event_total, invoice_date: @incoming_service_tax.invoice_date, invoice_number: @incoming_service_tax.invoice_number, service_tax: @incoming_service_tax.service_tax }
    end

    assert_redirected_to incoming_service_tax_path(assigns(:incoming_service_tax))
  end

  test "should show incoming_service_tax" do
    get :show, id: @incoming_service_tax
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incoming_service_tax
    assert_response :success
  end

  test "should update incoming_service_tax" do
    patch :update, id: @incoming_service_tax, incoming_service_tax: { description: @incoming_service_tax.description, event_total: @incoming_service_tax.event_total, invoice_date: @incoming_service_tax.invoice_date, invoice_number: @incoming_service_tax.invoice_number, service_tax: @incoming_service_tax.service_tax }
    assert_redirected_to incoming_service_tax_path(assigns(:incoming_service_tax))
  end

  test "should destroy incoming_service_tax" do
    assert_difference('IncomingServiceTax.count', -1) do
      delete :destroy, id: @incoming_service_tax
    end

    assert_redirected_to incoming_service_taxes_path
  end
end
