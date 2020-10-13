class Bench::Admin::FundUsesController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_fund_use, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    q_params = {}
    q_params.merge! params.permit(:id)

    @fund_uses = @project.fund_uses.default_where(q_params).page(params[:page])
  end

  def show
  end

  def new
    @fund_use = @project.fund_uses.build
  end

  def edit
  end

  def create
    @fund_use = @project.fund_uses.build(fund_use_params)

    if @fund_use.save
      render 'create'
    else
      render :new, locals: { model: @fund_use }, status: :unprocessable_entity
    end
  end

  def update
    @fund_use.assign_attributes fund_use_params

    if @fund_use.save
      render 'update'
    else
      render :edit, locals: { model: @fund_use }, status: :unprocessable_entity
    end
  end

  def destroy
    @fund_use.destroy
  end

  private
  def prepare_form
    q_params = {
      'id-not': @project.fund_uses.pluck(:fund_id)
    }

    @funds = Fund.default_where(q_params)
  end

  def set_project
    @project = Project.find params[:project_id]
  end

  def set_fund_use
    @fund_use = @project.fund_uses.find params[:id]
  end

  def fund_use_params
    params.fetch(:fund_use, {}).permit(
      :fund_id,
      :budget_amount,
      :note
    )
  end
end
