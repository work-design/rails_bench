require "application_system_test_case"

class ProjectFacilitatesTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_facilitate = bench_admin_project_facilitates(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_facilitates_url
    assert_selector "h1", text: "Project Facilitates"
  end

  test "creating a Project facilitate" do
    visit bench_admin_project_facilitates_url
    click_on "New Project Facilitate"

    fill_in "Facilitate", with: @bench_admin_project_facilitate.facilitate_id
    fill_in "Provider", with: @bench_admin_project_facilitate.provider_id
    click_on "Create Project facilitate"

    assert_text "Project facilitate was successfully created"
    click_on "Back"
  end

  test "updating a Project facilitate" do
    visit bench_admin_project_facilitates_url
    click_on "Edit", match: :first

    fill_in "Facilitate", with: @bench_admin_project_facilitate.facilitate_id
    fill_in "Provider", with: @bench_admin_project_facilitate.provider_id
    click_on "Update Project facilitate"

    assert_text "Project facilitate was successfully updated"
    click_on "Back"
  end

  test "destroying a Project facilitate" do
    visit bench_admin_project_facilitates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project facilitate was successfully destroyed"
  end
end
