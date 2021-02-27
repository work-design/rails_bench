module Bench
  class Admin::BudgetsController < Finance::Admin::BudgetsController
    include BenchController::Admin
    before_action :set_project
    before_action :set_expense, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form

    def index
      q_params = {}
      q_params.merge! params.permit(:financial_taxon_id)

      @budgets = @project.budgets.default_where(q_params).page(params[:page])
    end

    def new
      @budget = @project.budgets.build
      @budget.expense_items.build
    end

    def create
      @budget = @project.budgets.build(expense_params)

      unless @budget.save
        render :new, locals: { model: @budget }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
      super
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
      @financial_taxons = Finance::FinancialTaxon.default_where(default_params)
    end

    def expense_params
      params.fetch(:budget, {}).permit(
        :subject,
        :amount,
        :note,
        :financial_taxon_id,
        expense_items_attributes: {}
      )
    end

  end
end
