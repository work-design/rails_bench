require "application_system_test_case"

class TaskMastersTest < ApplicationSystemTestCase
  setup do
    @bench_admin_task_master = bench_admin_task_masters(:one)
  end

  test "visiting the index" do
    visit bench_admin_task_masters_url
    assert_selector "h1", text: "Task Masters"
  end

  test "creating a Task master" do
    visit bench_admin_task_masters_url
    click_on "New Task Master"

    fill_in "Member", with: @bench_admin_task_master.member_id
    fill_in "Tasking type", with: @bench_admin_task_master.tasking_type
    click_on "Create Task master"

    assert_text "Task master was successfully created"
    click_on "Back"
  end

  test "updating a Task master" do
    visit bench_admin_task_masters_url
    click_on "Edit", match: :first

    fill_in "Member", with: @bench_admin_task_master.member_id
    fill_in "Tasking type", with: @bench_admin_task_master.tasking_type
    click_on "Update Task master"

    assert_text "Task master was successfully updated"
    click_on "Back"
  end

  test "destroying a Task master" do
    visit bench_admin_task_masters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task master was successfully destroyed"
  end
end
