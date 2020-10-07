require "application_system_test_case"

class ProjectPreferencesTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_preference = bench_admin_project_preferences(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_preferences_url
    assert_selector "h1", text: "Project Preferences"
  end

  test "creating a Project preference" do
    visit bench_admin_project_preferences_url
    click_on "New Project Preference"

    fill_in "Facilitate", with: @bench_admin_project_preference.facilitate_id
    fill_in "Provider", with: @bench_admin_project_preference.provider_id
    click_on "Create Project preference"

    assert_text "Project preference was successfully created"
    click_on "Back"
  end

  test "updating a Project preference" do
    visit bench_admin_project_preferences_url
    click_on "Edit", match: :first

    fill_in "Facilitate", with: @bench_admin_project_preference.facilitate_id
    fill_in "Provider", with: @bench_admin_project_preference.provider_id
    click_on "Update Project preference"

    assert_text "Project preference was successfully updated"
    click_on "Back"
  end

  test "destroying a Project preference" do
    visit bench_admin_project_preferences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project preference was successfully destroyed"
  end
end
