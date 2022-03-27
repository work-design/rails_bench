module Bench
  class Me::ProjectsController < Admin::ProjectsController
    include Controller::Me
    before_action :set_project, only: [:show, :task_templates, :edit, :repos, :github_hook, :update, :destroy]
    before_action :prepare_form, only: [:index, :new, :edit]

    def index
      q_params = {}
      q_params.merge! params.permit(:project_taxon_id, :project_stage_id, 'name-like')

      @projects = current_member.projects.default_where(q_params).page(params[:page])
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

    def task_templates
      @task_templates = TaskTemplate.where(tasking_type: 'Project', tasking_id: @project.id).page(params[:page])
    end

    def repos
      @repos = @project.creator&.github_repos
      render json: { results: @repos }
    end

    def github_hook
      @project.github_hook_add
    end

    private
    def set_project
      @project = Project.find(params[:id])
    end

    def prepare_form
      @project_taxons = Taxon.default_where(default_params)
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
end
