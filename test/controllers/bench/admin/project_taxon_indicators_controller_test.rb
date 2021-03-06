require 'test_helper'
class Bench::Admin::TaxonIndicatorsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_admin_taxon_indicator = create :taxon_indicators
  end

  test 'index ok' do
    get admin_project_taxon_indicators_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_project_taxon_indicator_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('ProjectTaxonIndicator.count') do
      post admin_project_taxon_indicators_url, params: { }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_project_taxon_indicator_url(@taxon_indicator)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_project_taxon_indicator_url(@taxon_indicator)
    assert_response :success
  end

  test 'update ok' do
    patch admin_project_taxon_indicator_url(@taxon_indicator), params: { }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('ProjectTaxonIndicator.count', -1) do
      delete admin_project_taxon_indicator_url(@taxon_indicator)
    end

    assert_response :success
  end

end
