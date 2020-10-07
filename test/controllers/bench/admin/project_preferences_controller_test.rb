require 'test_helper'
class Bench::Admin::ProjectPreferencesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_project_preference = create bench_admin_project_preferences
  end

  test 'index ok' do
    get admin_project_preferences_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_project_preference_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProjectPreference.count') do
      post admin_project_preferences_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_project_preference_url(@bench_admin_project_preference)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_project_preference_url(@bench_admin_project_preference)
    assert_response :success
  end

  test 'update ok' do
    patch admin_project_preference_url(@bench_admin_project_preference), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProjectPreference.count', -1) do
      delete admin_project_preference_url(@bench_admin_project_preference)
    end

    assert_response :success
  end

end
