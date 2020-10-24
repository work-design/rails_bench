class Bench::Admin::ProjectMilepostsController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_project_milepost, only: [:edit, :update, :destroy]

  def new
    @project_milepost = @project.project_mileposts.build
  end

  def create
    @project_milepost = @project.project_mileposts.build(project_milepost_params)

    unless @project_milepost.save
      render :new, locals: { model: @project_milepost }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @project_milepost.assign_attributes(project_milepost_params)

    unless @project_milepost.save
      render :edit, locals: { model: @project_milepost }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_milepost.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_project_milepost
    @project_milepost = @project.project_mileposts.find params[:id]
  end

  def project_milepost_params
    params.fetch(:project_milepost, {}).permit(
      :milepost_id,
      :recorded_on,
      :current
    )
  end

end
