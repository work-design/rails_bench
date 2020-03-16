class Bench::My::ProjectFundsController < Bench::My::BaseController
  before_action :set_project
  before_action :set_project_fund, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:id)
    @project_funds = @project.project_funds.page(params[:page])
  end

  def show
  end

  def new
    @project_fund = @project.project_funds.build
  end

  def edit
  end

  def create
    @project_fund = @project.project_funds.build(project_fund_params)

    if @project_fund.save
      render 'create', locals: { return_to: my_project_funds_url(@project_fund.project_id) }
    else
      render :new, locals: { model: @project_fund }, status: :unprocessable_entity
    end
  end

  def update
    if @project_fund.update(project_fund_params)
      render 'update', locals: { return_to: my_project_funds_url(@project_fund.project_id) }
    else
      render :edit, locals: { model: @project_fund }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_fund.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_project_fund
    @project_fund = ProjectFund.find(params[:id])
  end

  def project_fund_params
    q = params.fetch(:project_fund, {}).permit(
      :price,
      :visible
    )
    q.merge! user_id: current_user.id
    q
  end
end
