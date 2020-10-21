class Bench::Admin::ProjectsController < Bench::Admin::BaseController
  before_action :set_project, only: [:show, :task_templates, :edit, :repos, :github_hook, :update, :destroy]
  before_action :prepare_form, only: [:index, :new, :edit]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:project_taxon_id, :project_stage_id, 'name-like')

    @projects = Project.default_where(q_params).order(id: :desc).page(params[:page])
  end

  def new
    @project = current_member.projects.build(project_taxon_id: params[:project_taxon_id])
  end

  def create
    @project = current_member.projects.build(project_params)

    unless @project.save
      render :new, locals: { model: @project }, status: :unprocessable_entity
    end
  end

  def show
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
      render 'update', locals: { return_to: me_project_path(@project) }
    else
      render :edit, locals: { model: @project }, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def prepare_form
    @project_taxons = ProjectTaxon.default_where(default_params)
    @project_stages = ProjectStage.default_where(default_params)
  end

  def project_params
    p = params.fetch(:project, {}).permit(
      :name,
      :project_taxon_id,
      :project_stage_id,
      :budget,
      :description,
      :github_repo,
      extra: {}
    )
    p.merge! default_form_params
  end

end
