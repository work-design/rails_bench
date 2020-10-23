require 'test_helper'
class Bench::Admin::MilepostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_milepost = create bench_admin_mileposts
  end

  test 'index ok' do
    get admin_mileposts_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_milepost_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Milepost.count') do
      post admin_mileposts_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_milepost_url(@bench_admin_milepost)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_milepost_url(@bench_admin_milepost)
    assert_response :success
  end

  test 'update ok' do
    patch admin_milepost_url(@bench_admin_milepost), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Milepost.count', -1) do
      delete admin_milepost_url(@bench_admin_milepost)
    end

    assert_response :success
  end

end
