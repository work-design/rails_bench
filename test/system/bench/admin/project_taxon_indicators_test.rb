require "application_system_test_case"

class ProjectTaxonIndicatorsTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_taxon_indicator = bench_admin_project_taxon_indicators(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_taxon_indicators_url
    assert_selector "h1", text: "Project Taxon Indicators"
  end

  test "creating a Project taxon indicator" do
    visit bench_admin_project_taxon_indicators_url
    click_on "New Project Taxon Indicator"

    fill_in "Facilitate taxon", with: @bench_admin_project_taxon_indicator.facilitate_taxon_id
    fill_in "Indicator", with: @bench_admin_project_taxon_indicator.indicator_id
    click_on "Create Project taxon indicator"

    assert_text "Project taxon indicator was successfully created"
    click_on "Back"
  end

  test "updating a Project taxon indicator" do
    visit bench_admin_project_taxon_indicators_url
    click_on "Edit", match: :first

    fill_in "Facilitate taxon", with: @bench_admin_project_taxon_indicator.facilitate_taxon_id
    fill_in "Indicator", with: @bench_admin_project_taxon_indicator.indicator_id
    click_on "Update Project taxon indicator"

    assert_text "Project taxon indicator was successfully updated"
    click_on "Back"
  end

  test "destroying a Project taxon indicator" do
    visit bench_admin_project_taxon_indicators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project taxon indicator was successfully destroyed"
  end
end
