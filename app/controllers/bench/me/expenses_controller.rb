class Bench::Me::ExpensesController < Bench::Me::BaseController
  before_action :set_project
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.page(params[:page])
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    unless @expense.save
      render :new, locals: { model: @expense }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @expense.assign_attributes(expense_params)

    unless @expense.save
      render :edit, locals: { model: @expense }, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.fetch(:expense, {}).permit(
      :subject,
      :amount,
      :note,
      :financial_taxon_id,
      :invoices_count
    )
  end

end
