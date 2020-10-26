require "application_system_test_case"

class FacilitateIndicatorsTest < ApplicationSystemTestCase
  setup do
    @bench_admin_facilitate_indicator = bench_admin_facilitate_indicators(:one)
  end

  test "visiting the index" do
    visit bench_admin_facilitate_indicators_url
    assert_selector "h1", text: "Facilitate Indicators"
  end

  test "creating a Facilitate indicator" do
    visit bench_admin_facilitate_indicators_url
    click_on "New Facilitate Indicator"

    fill_in "Indicator", with: @bench_admin_facilitate_indicator.indicator_id
    fill_in "Note", with: @bench_admin_facilitate_indicator.note
    click_on "Create Facilitate indicator"

    assert_text "Facilitate indicator was successfully created"
    click_on "Back"
  end

  test "updating a Facilitate indicator" do
    visit bench_admin_facilitate_indicators_url
    click_on "Edit", match: :first

    fill_in "Indicator", with: @bench_admin_facilitate_indicator.indicator_id
    fill_in "Note", with: @bench_admin_facilitate_indicator.note
    click_on "Update Facilitate indicator"

    assert_text "Facilitate indicator was successfully updated"
    click_on "Back"
  end

  test "destroying a Facilitate indicator" do
    visit bench_admin_facilitate_indicators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facilitate indicator was successfully destroyed"
  end
end
