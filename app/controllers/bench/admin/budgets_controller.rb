class Bench::Admin::BudgetsController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form

  def index
    @budgets = @project.budgets.page(params[:page])
  end

  def new
    @budget = @project.budgets.build
  end

  def create
    @budget = @project.budgets.build(expense_params)
    @budget.creator = current_member if defined? current_member

    unless @budget.save
      render :new, locals: { model: @budget }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @budget.assign_attributes(expense_params)

    unless @budget.save
      render :edit, locals: { model: @budget }, status: :unprocessable_entity
    end
  end

  def destroy
    @budget.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_expense
    @budget = @project.budgets.find(params[:id])
  end

  def prepare_form
    @financial_taxons = FinancialTaxon.default_where(default_params)
  end

  def expense_params
    params.fetch(:budget, {}).permit(
      :subject,
      :amount,
      :note,
      :financial_taxon_id
    )
  end

end
