require "application_system_test_case"

class MilepostsTest < ApplicationSystemTestCase
  setup do
    @bench_admin_milepost = bench_admin_mileposts(:one)
  end

  test "visiting the index" do
    visit bench_admin_mileposts_url
    assert_selector "h1", text: "Mileposts"
  end

  test "creating a Milepost" do
    visit bench_admin_mileposts_url
    click_on "New Milepost"

    fill_in "Name", with: @bench_admin_milepost.name
    fill_in "Project mileposts count", with: @bench_admin_milepost.project_mileposts_count
    click_on "Create Milepost"

    assert_text "Milepost was successfully created"
    click_on "Back"
  end

  test "updating a Milepost" do
    visit bench_admin_mileposts_url
    click_on "Edit", match: :first

    fill_in "Name", with: @bench_admin_milepost.name
    fill_in "Project mileposts count", with: @bench_admin_milepost.project_mileposts_count
    click_on "Update Milepost"

    assert_text "Milepost was successfully updated"
    click_on "Back"
  end

  test "destroying a Milepost" do
    visit bench_admin_mileposts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Milepost was successfully destroyed"
  end
end
