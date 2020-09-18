class Bench::Admin::ProjectStagesController < Bench::Admin::BaseController
  before_action :set_project_stage, only: [:show, :edit, :update, :destroy]

  def index
    @project_stages = ProjectStage.page(params[:page])
  end

  def new
    @project_stage = ProjectStage.new
  end

  def create
    @project_stage = ProjectStage.new(project_stage_params)

    unless @project_stage.save
      render :new, locals: { model: @project_stage }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_stage.assign_attributes(project_stage_params)

    unless @project_stage.save
      render :edit, locals: { model: @project_stage }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_stage.destroy
  end

  private
  def set_project_stage
    @project_stage = ProjectStage.find(params[:id])
  end

  def project_stage_params
    params.fetch(:project_stage, {}).permit(
      :name,
      :begin_on,
      :end_on,
      :state
    )
  end

end
