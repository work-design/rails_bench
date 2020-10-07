require 'test_helper'
class Bench::Admin::ProjectFacilitatesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_project_facilitate = create bench_admin_project_facilitates
  end

  test 'index ok' do
    get admin_project_facilitates_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_project_facilitate_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProjectFacilitate.count') do
      post admin_project_facilitates_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_project_facilitate_url(@bench_admin_project_facilitate)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_project_facilitate_url(@bench_admin_project_facilitate)
    assert_response :success
  end

  test 'update ok' do
    patch admin_project_facilitate_url(@bench_admin_project_facilitate), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProjectFacilitate.count', -1) do
      delete admin_project_facilitate_url(@bench_admin_project_facilitate)
    end

    assert_response :success
  end

end
