require 'test_helper'
class Bench::Admin::FacilitateIndicatorsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_facilitate_indicator = create bench_admin_facilitate_indicators
  end

  test 'index ok' do
    get admin_facilitate_indicators_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_facilitate_indicator_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('FacilitateIndicator.count') do
      post admin_facilitate_indicators_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_facilitate_indicator_url(@bench_admin_facilitate_indicator)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_facilitate_indicator_url(@bench_admin_facilitate_indicator)
    assert_response :success
  end

  test 'update ok' do
    patch admin_facilitate_indicator_url(@bench_admin_facilitate_indicator), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('FacilitateIndicator.count', -1) do
      delete admin_facilitate_indicator_url(@bench_admin_facilitate_indicator)
    end

    assert_response :success
  end

end
