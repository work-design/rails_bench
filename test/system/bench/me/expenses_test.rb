require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @bench_me_expense = bench_me_expenses(:one)
  end

  test "visiting the index" do
    visit bench_me_expenses_url
    assert_selector "h1", text: "Expenses"
  end

  test "creating a Expense" do
    visit bench_me_expenses_url
    click_on "New Expense"

    fill_in "Amount", with: @bench_me_expense.amount
    fill_in "Financial taxon", with: @bench_me_expense.financial_taxon_id
    fill_in "Invoices count", with: @bench_me_expense.invoices_count
    fill_in "Note", with: @bench_me_expense.note
    fill_in "Subject", with: @bench_me_expense.subject
    click_on "Create Expense"

    assert_text "Expense was successfully created"
    click_on "Back"
  end

  test "updating a Expense" do
    visit bench_me_expenses_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @bench_me_expense.amount
    fill_in "Financial taxon", with: @bench_me_expense.financial_taxon_id
    fill_in "Invoices count", with: @bench_me_expense.invoices_count
    fill_in "Note", with: @bench_me_expense.note
    fill_in "Subject", with: @bench_me_expense.subject
    click_on "Update Expense"

    assert_text "Expense was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense" do
    visit bench_me_expenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense was successfully destroyed"
  end
end
