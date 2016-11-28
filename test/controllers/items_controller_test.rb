require 'test_helper'

class Admin::ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:item) 
  end

  test "should get index" do
    get admin_items_url,
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should get new" do
    get new_admin_item_url,
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post admin_items_url, params: { item: { name: @item.name, price: @item.price } },
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    end

    assert_redirected_to admin_items_url
  end

  test "should show item" do
    get admin_item_url(@item),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 

    assert_response :success
  end

  test "should get edit" do
    get edit_admin_item_url(@item),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 

    assert_response :success
  end

  test "should update item" do
    patch admin_item_url(@item), params: { item: { name: @item.name, price: @item.price } },
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    assert_redirected_to admin_items_url
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete admin_item_url(@item),
      headers: { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'admin')} 
    end

    assert_redirected_to admin_items_url
  end
end
