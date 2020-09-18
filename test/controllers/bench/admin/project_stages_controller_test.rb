require 'test_helper'
class Bench::Admin::ProjectStagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_project_stage = create bench_admin_project_stages
  end

  test 'index ok' do
    get admin_project_stages_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_project_stage_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProjectStage.count') do
      post admin_project_stages_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_project_stage_url(@bench_admin_project_stage)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_project_stage_url(@bench_admin_project_stage)
    assert_response :success
  end

  test 'update ok' do
    patch admin_project_stage_url(@bench_admin_project_stage), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProjectStage.count', -1) do
      delete admin_project_stage_url(@bench_admin_project_stage)
    end

    assert_response :success
  end

end
