class Bench::Admin::FundsController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_fund, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:id)

    @funds = @project.funds.default_where(q_params).page(params[:page])
  end

  def show
  end

  def new
    @fund = @project.funds.build
  end

  def edit
  end

  def create
    @fund = @project.funds.build(fund_params)

    if @fund.save
      render 'create'
    else
      render :new, locals: { model: @fund }, status: :unprocessable_entity
    end
  end

  def update
    @fund.assign_attributes fund_params

    if @fund.save
      render 'update'
    else
      render :edit, locals: { model: @fund }, status: :unprocessable_entity
    end
  end

  def destroy
    @fund.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_fund
    @fund = @project.funds.find params[:id]
  end

  def fund_params
    q = params.fetch(:fund, {}).permit(
      :amount,
      :note,
      :visible,
      :proof
    )
    q.merge! user_id: current_user.id
    q
  end
end
