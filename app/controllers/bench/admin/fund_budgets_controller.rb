class Bench::Admin::FundBudgetsController < Bench::Admin::BaseController
  before_action :set_financial
  before_action :set_fund_budget, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    q_params = {}
    q_params.merge! params.permit(:id)

    @fund_budgets = @financial.fund_budgets.default_where(q_params).page(params[:page])
  end

  def show
  end

  def new
    @fund_budget = @financial.fund_budgets.build
  end

  def edit
  end

  def create
    @fund_budget = @financial.fund_budgets.build(fund_budget_params)

    if @fund_budget.save
      render 'create'
    else
      render :new, locals: { model: @fund_budget }, status: :unprocessable_entity
    end
  end

  def update
    @fund_budget.assign_attributes fund_budget_params

    if @fund_budget.save
      render 'update'
    else
      render :edit, locals: { model: @fund_budget }, status: :unprocessable_entity
    end
  end

  def destroy
    @fund_budget.destroy
  end

  private
  def prepare_form
    @funds = Fund.where.not(id: @financial.fund_budgets.pluck(:fund_id))
  end

  def set_financial
    case params[:financial_type]
    when 'Project'
      @financial = Project.find params[:financial_id]
    when 'ProjectStage'
      @financial = ProjectStage.find params[:financial_id]
    when 'ProjectTaxon'
      @financial = ProjectTaxon.find params[:financial_id]
    end
  end

  def set_fund_budget
    @fund_budget = @financial.fund_budgets.find params[:id]
  end

  def fund_budget_params
    params.fetch(:fund_budget, {}).permit(
      :fund_id,
      :amount,
      :note
    )
  end
end
