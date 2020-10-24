require "application_system_test_case"

class ProjectMilepostsTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_milepost = bench_admin_project_mileposts(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_mileposts_url
    assert_selector "h1", text: "Project Mileposts"
  end

  test "creating a Project milepost" do
    visit bench_admin_project_mileposts_url
    click_on "New Project Milepost"

    fill_in "Current", with: @bench_admin_project_milepost.current
    fill_in "Milepost", with: @bench_admin_project_milepost.milepost_id
    fill_in "Recorded on", with: @bench_admin_project_milepost.recorded_on
    click_on "Create Project milepost"

    assert_text "Project milepost was successfully created"
    click_on "Back"
  end

  test "updating a Project milepost" do
    visit bench_admin_project_mileposts_url
    click_on "Edit", match: :first

    fill_in "Current", with: @bench_admin_project_milepost.current
    fill_in "Milepost", with: @bench_admin_project_milepost.milepost_id
    fill_in "Recorded on", with: @bench_admin_project_milepost.recorded_on
    click_on "Update Project milepost"

    assert_text "Project milepost was successfully updated"
    click_on "Back"
  end

  test "destroying a Project milepost" do
    visit bench_admin_project_mileposts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project milepost was successfully destroyed"
  end
end
