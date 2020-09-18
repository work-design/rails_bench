require "application_system_test_case"

class ProjectStagesTest < ApplicationSystemTestCase
  setup do
    @bench_admin_project_stage = bench_admin_project_stages(:one)
  end

  test "visiting the index" do
    visit bench_admin_project_stages_url
    assert_selector "h1", text: "Project Stages"
  end

  test "creating a Project stage" do
    visit bench_admin_project_stages_url
    click_on "New Project Stage"

    fill_in "Begin on", with: @bench_admin_project_stage.begin_on
    fill_in "End on", with: @bench_admin_project_stage.end_on
    fill_in "Name", with: @bench_admin_project_stage.name
    fill_in "State", with: @bench_admin_project_stage.state
    click_on "Create Project stage"

    assert_text "Project stage was successfully created"
    click_on "Back"
  end

  test "updating a Project stage" do
    visit bench_admin_project_stages_url
    click_on "Edit", match: :first

    fill_in "Begin on", with: @bench_admin_project_stage.begin_on
    fill_in "End on", with: @bench_admin_project_stage.end_on
    fill_in "Name", with: @bench_admin_project_stage.name
    fill_in "State", with: @bench_admin_project_stage.state
    click_on "Update Project stage"

    assert_text "Project stage was successfully updated"
    click_on "Back"
  end

  test "destroying a Project stage" do
    visit bench_admin_project_stages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project stage was successfully destroyed"
  end
end
