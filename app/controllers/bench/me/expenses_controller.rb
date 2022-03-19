module Bench
  class Me::ExpensesController < Admin::ExpensesController
    include Controller::Me
    before_action :set_project
    before_action :set_expense, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form

    def index
      @expenses = @project.expenses.page(params[:page])
    end

    def new
      @expense = @project.expenses.build
      @expense.expense_items.build
    end

    def create
      @expense = @project.expenses.build(expense_params)
      @expense.creator = current_member

      unless @expense.save
        render :new, locals: { model: @expense }, status: :unprocessable_entity
      end
    end

    def add_item
      @expense = current_member.created_expenses.build(type: params[:type], financial_taxon_id: params[:financial_taxon_id])
      if @expense.financial_taxon
        @taxon_options = @expense.financial_taxon.children.map { |i| [i.name, i.id] }
      else
        @taxon_options = []
      end
      @expense.expense_items.build
    end

    def add_member
      @expense = current_member.created_expenses.build(type: params[:type], financial_taxon_id: params[:financial_taxon_id])
      @expense.expense_members.build
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
end
