class Bench::Admin::ProjectFacilitatesController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_project_facilitate, only: [:show, :edit, :update, :destroy]

  def index
    @project_facilitates = ProjectFacilitate.page(params[:page])
  end

  def new
    @project_facilitate = ProjectFacilitate.new
  end

  def create
    @project_facilitate = ProjectFacilitate.new(project_facilitate_params)

    unless @project_facilitate.save
      render :new, locals: { model: @project_facilitate }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_facilitate.assign_attributes(project_facilitate_params)

    unless @project_facilitate.save
      render :edit, locals: { model: @project_facilitate }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_facilitate.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_project_facilitate
    @project_facilitate = ProjectFacilitate.find(params[:id])
  end

  def project_facilitate_params
    params.fetch(:project_facilitate, {}).permit(
      :facilitate_id,
      :provider_id
    )
  end

end
