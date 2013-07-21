require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @coordinator = organizations(:coord_one)
  end

  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coordinators)
  end

  test "certain index buttons require login" do
    get :index
    assert_select "a", {count: 0, text: "New Organization"}, "Shouldn't have a new button"
    assert_select "a", {count: 0, text: "Edit"}, "Shouldn't have an edit button"
    assert_select "a", {count: 0, text: "Delete"}, "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    sign_in User.first
    get :index
    assert_select "a", "New Organization", "Should have a new button"
    assert_select "a", "Edit", "Should have an edit button"
    assert_select "a", "Delete", "Should have a delete button"
  end

  test "require login to get new" do
    get :new
    assert_response :redirect #302
  end

  test "get new" do
    sign_in User.first
    get :new
    assert_response :success
  end

  test "require login to create coordinator" do
    assert_no_difference('Organization.count') do
      post :create, organization: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    end
  end

  test "create organization when logged in" do
    sign_in User.first
    assert_difference('Organization.count') do
      post :create, organization: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    end

    new_org = assigns(:coordinator)
    # should have the user that created it
    new_org.members.admins.size.wont_equal 0
    assert_redirected_to organization_path(new_org)
    
  end

  test "show coordinator" do
    get :show, id: @coordinator
    assert_response :success
  end

  test "require login to get edit" do
    get :edit, id: @coordinator
    assert_response :redirect #302
  end

  test "get edit" do
    sign_in User.first
    get :edit, id: @coordinator
    assert_response :success
  end

  test "require login to update coordinator" do
    put :update, id: @coordinator, organization: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    assert_redirected_to user_session_path
  end

  test "update coordinator" do
    sign_in User.first
    put :update, id: @coordinator, organization: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    assert_redirected_to organization_path(assigns(:coordinator))
  end

  test "require login to destroy coordinator" do
    assert_no_difference('Organization.count') do
      delete :destroy, id: @coordinator
    end
  end

  test "destroy coordinator" do
    sign_in User.first
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @coordinator
    end

    assert_redirected_to organizations_path
  end
end
