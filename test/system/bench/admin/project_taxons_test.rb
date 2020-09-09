require "application_system_test_case"

class ProjectTaxonsTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_taxon = bench_admin_project_taxons(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_taxons_url
    assert_selector "h1", text: "Project Taxons"
  end

  test "creating a Project taxon" do
    visit bench_admin_project_taxons_url
    click_on "New Project Taxon"

    fill_in "Name", with: @bench_admin_project_taxon.name
    click_on "Create Project taxon"

    assert_text "Project taxon was successfully created"
    click_on "Back"
  end

  test "updating a Project taxon" do
    visit bench_admin_project_taxons_url
    click_on "Edit", match: :first

    fill_in "Name", with: @bench_admin_project_taxon.name
    click_on "Update Project taxon"

    assert_text "Project taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Project taxon" do
    visit bench_admin_project_taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project taxon was successfully destroyed"
  end
end
