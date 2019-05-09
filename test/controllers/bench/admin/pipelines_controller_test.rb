require 'test_helper'

class Bench::Admin::PipelinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bench_admin_pipeline = create bench_admin_pipelines
  end

  test 'index ok' do
    get admin_pipelines_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_pipeline_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Pipeline.count') do
      post admin_pipelines_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to bench_admin_pipeline_url(Pipeline.last)
  end

  test 'show ok' do
    get admin_pipeline_url(@bench_admin_pipeline)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_pipeline_url(@bench_admin_pipeline)
    assert_response :success
  end

  test 'update ok' do
    patch admin_pipeline_url(@bench_admin_pipeline), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to bench_admin_pipeline_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Pipeline.count', -1) do
      delete admin_pipeline_url(@bench_admin_pipeline)
    end

    assert_redirected_to admin_pipelines_url
  end
end
