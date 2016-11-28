require 'test_helper'

class Admin::PromocodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promocode = create(:promocode) 
  end

  test "should get index" do
    get admin_promocodes_url, 
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should get new" do
    get new_admin_promocode_url,
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should create promocode" do
    assert_difference('Promocode.count') do
      post admin_promocodes_url, params: { promocode: { name: @promocode.name, promo_type: @promocode.promo_type, used_in_conjuncation: @promocode.used_in_conjuncation, value: @promocode.value } },
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    end

    assert_redirected_to admin_promocodes_url
  end

  test "should show promocode" do
    get admin_promocode_url(@promocode),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_promocode_url(@promocode),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should update promocode" do
    patch admin_promocode_url(@promocode), params: { promocode: { name: @promocode.name, promo_type: @promocode.promo_type, used_in_conjuncation: @promocode.used_in_conjuncation, value: @promocode.value } },
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_redirected_to admin_promocodes_url
  end

  test "should destroy promocode" do
    assert_difference('Promocode.count', -1) do
      delete admin_promocode_url(@promocode),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    end

    assert_redirected_to admin_promocodes_url
  end
end
