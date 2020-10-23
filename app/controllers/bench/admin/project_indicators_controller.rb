class Bench::Admin::ProjectIndicatorsController < Bench::Admin::BaseController
  before_action :set_project
  before_action :pre_form, only: [:edit, :new, :update, :create]
  before_action :set_project_indicator, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}

    @project_indicators = @project.project_indicators.default_where(q_params).page(params[:page])
  end

  def new
    @project_indicator = @project.project_indicators.build
  end

  def create
    @project_indicator = @project.project_indicators.build(project_indicator_params)

    if @project_indicator.save
      render 'create'
    else
      render action: 'new', locals: { model: @project_indicator }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_indicator.assign_attributes(project_indicator_params)

    if @project_indicator.save
      render 'update'
    else
      render action: 'edit', locals: { model: @project_indicator }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_indicator.destroy
  end

  private
  def pre_form
    @indicators = Indicator.all
  end

  def set_project
    @project = Project.find params[:project_id]
  end

  def set_project_indicator
    @project_indicator = ProjectIndicator.find params[:id]
  end

  def project_indicator_params
    params.fetch(:project_indicator, {}).permit(
      :value,
      :source,
      :comment,
      :indicator_id
    )
  end
end
