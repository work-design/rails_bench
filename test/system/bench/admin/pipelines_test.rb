require "application_system_test_case"

class PipelinesTest < ApplicationSystemTestCase
  setup do
    @bench_admin_pipeline = bench_admin_pipelines(:one)
  end

  test "visiting the index" do
    visit bench_admin_pipelines_url
    assert_selector "h1", text: "Pipelines"
  end

  test "creating a Pipeline" do
    visit bench_admin_pipelines_url
    click_on "New Pipeline"

    fill_in "Description", with: @bench_admin_pipeline.description
    fill_in "Name", with: @bench_admin_pipeline.name
    fill_in "Piping type", with: @bench_admin_pipeline.piping_type
    click_on "Create Pipeline"

    assert_text "Pipeline was successfully created"
    click_on "Back"
  end

  test "updating a Pipeline" do
    visit bench_admin_pipelines_url
    click_on "Edit", match: :first

    fill_in "Description", with: @bench_admin_pipeline.description
    fill_in "Name", with: @bench_admin_pipeline.name
    fill_in "Piping type", with: @bench_admin_pipeline.piping_type
    click_on "Update Pipeline"

    assert_text "Pipeline was successfully updated"
    click_on "Back"
  end

  test "destroying a Pipeline" do
    visit bench_admin_pipelines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pipeline was successfully destroyed"
  end
end
