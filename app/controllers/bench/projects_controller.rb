class Bench::ProjectsController < Bench::BaseController
  before_action :set_project, only: [:show, :github, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:github]

  def index
    @projects = Project.all.page(params[:page])
  end

  def show
  end

  def github
    @project.project_webhooks.create origin_data: params.permit!
    head :no_content
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(
      :name,
      :description
    )
  end

end
