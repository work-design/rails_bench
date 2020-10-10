class Bench::Admin::ExpensesController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form

  def index
    @expenses = @project.expenses.page(params[:page])
  end

  def new
    @expense = @project.expenses.build
  end

  def create
    @expense = @project.expenses.build(expense_params)
    @expense.creator = current_member if defined? current_member

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
    @expense = @project.expenses.find(params[:id])
  end

  def prepare_form
    @financial_taxons = FinancialTaxon.default_where(default_params)
  end

  def expense_params
    params.fetch(:expense, {}).permit(
      :subject,
      :amount,
      :note,
      :financial_taxon_id
    )
  end

end
