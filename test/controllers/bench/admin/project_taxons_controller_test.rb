require 'test_helper'
class Bench::Admin::ProjectTaxonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_project_taxon = create bench_admin_project_taxons
  end

  test 'index ok' do
    get admin_project_taxons_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_project_taxon_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProjectTaxon.count') do
      post admin_project_taxons_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_project_taxon_url(@bench_admin_project_taxon)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_project_taxon_url(@bench_admin_project_taxon)
    assert_response :success
  end

  test 'update ok' do
    patch admin_project_taxon_url(@bench_admin_project_taxon), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProjectTaxon.count', -1) do
      delete admin_project_taxon_url(@bench_admin_project_taxon)
    end

    assert_response :success
  end

end
