require 'test_helper'
class Bench::Admin::TaskMastersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_task_master = create bench_admin_task_masters
  end

  test 'index ok' do
    get admin_task_masters_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_task_master_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('TaskMaster.count') do
      post admin_task_masters_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_task_master_url(@bench_admin_task_master)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_task_master_url(@bench_admin_task_master)
    assert_response :success
  end

  test 'update ok' do
    patch admin_task_master_url(@bench_admin_task_master), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('TaskMaster.count', -1) do
      delete admin_task_master_url(@bench_admin_task_master)
    end

    assert_response :success
  end

end
