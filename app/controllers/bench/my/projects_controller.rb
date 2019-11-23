class Bench::My::ProjectsController < Bench::My::BaseController
  before_action :set_project, only: [:show, :tasks, :edit, :repos, :github_hook, :update, :destroy]

  def index
    @projects = current_user.projects.page(params[:page])
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)

    unless @project.save
      render :new, locals: { model: @project }, status: :unprocessable_entity
    end
  end

  def show
  end

  def tasks
    @tasks = @project.tasks.roots
  end

  def repos
    @repos = @project.creator&.github_repos
    render json: { results: @repos }
  end

  def github_hook
    @project.github_hook_add
  end

  def edit
  end

  def update
    @project.assign_attributes project_params
    
    if @project.save
      render :edit, locals: { model: @project }, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to my_projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(
      :name,
      :description,
      :github_repo
    )
  end

end
