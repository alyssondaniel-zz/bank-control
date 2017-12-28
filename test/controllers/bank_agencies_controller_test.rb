require 'test_helper'

class BankAgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_agency = bank_agencies(:one)
  end

  test "should get index" do
    get bank_agencies_url
    assert_response :success
  end

  test "should get new" do
    get new_bank_agency_url
    assert_response :success
  end

  test "should create bank_agency" do
    assert_difference('BankAgency.count') do
      post bank_agencies_url, params: { bank_agency: { city: @bank_agency.city, country: @bank_agency.country, number: @bank_agency.number, state: @bank_agency.state, street: @bank_agency.street, zip: @bank_agency.zip } }
    end

    assert_redirected_to bank_agency_url(BankAgency.last)
  end

  test "should show bank_agency" do
    get bank_agency_url(@bank_agency)
    assert_response :success
  end

  test "should get edit" do
    get edit_bank_agency_url(@bank_agency)
    assert_response :success
  end

  test "should update bank_agency" do
    patch bank_agency_url(@bank_agency), params: { bank_agency: { city: @bank_agency.city, country: @bank_agency.country, number: @bank_agency.number, state: @bank_agency.state, street: @bank_agency.street, zip: @bank_agency.zip } }
    assert_redirected_to bank_agency_url(@bank_agency)
  end

  test "should destroy bank_agency" do
    assert_difference('BankAgency.count', -1) do
      delete bank_agency_url(@bank_agency)
    end

    assert_redirected_to bank_agencies_url
  end
end
