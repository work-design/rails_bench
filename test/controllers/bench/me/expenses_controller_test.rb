require 'test_helper'
class Bench::Me::ExpensesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @bench_me_expense = create bench_me_expenses
  end

  test 'index ok' do
    get me_expenses_url
    assert_response :success
  end

  test 'new ok' do
    get new_me_expense_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Expense.count') do
      post me_expenses_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get me_expense_url(@bench_me_expense)
    assert_response :success
  end

  test 'edit ok' do
    get edit_me_expense_url(@bench_me_expense)
    assert_response :success
  end

  test 'update ok' do
    patch me_expense_url(@bench_me_expense), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('Expense.count', -1) do
      delete me_expense_url(@bench_me_expense)
    end

    assert_response :success
  end

end
