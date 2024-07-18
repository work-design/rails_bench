module Bench
  class Admin::ExpensesController < Finance::Admin::ExpensesController
    include Controller::Admin
    before_action :set_project
    before_action :prepare_form

    def index
      q_params = {}
      q_params.merge! params.permit(:fund_expense_id)

      @expenses = @project.expenses.includes(:financial_taxon).default_where(q_params).page(params[:page])
    end

    def new
      @expense = @project.expenses.build
      @expense.expense_items.build
    end

    def create
      @expense = @project.expenses.build(expense_params)
      @expense.creator = current_member if defined? current_member

      unless @expense.save
        render :new, locals: { model: @expense }, status: :unprocessable_entity
      end
    end

    def add_item
      super
    end

    private
    def set_project
      @project = Project.find params[:project_id]
    end

    def set_expense
      @expense = @project.expenses.find(params[:id])
    end

    def prepare_form
      @financial_taxons = Finance::FinancialTaxon.default_where(default_params)
    end

    def expense_params
      params.fetch(:expense, {}).permit(
        :type,
        :subject,
        :amount,
        :note,
        :financial_taxon_id,
        expense_items_attributes: {}
      )
    end

  end
end
