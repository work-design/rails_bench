module Bench
  class Admin::ProjectsController < Admin::BaseController
    before_action :set_project, only: [:show, :task_templates, :edit, :repos, :github_hook, :update, :sync, :destroy]
    before_action :set_project_taxon, only: [:index, :show]
    before_action :prepare_form, only: [:index, :new, :edit]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:project_taxon_id, :project_stage_id, 'name-like', 'project_mileposts.milepost_id')
      if params[:project_stage_id]
        project_stage = ProjectStage.find params[:project_stage_id]
        q_params.merge! 'project_mileposts.recorded_on-gte': project_stage.begin_on, 'project_mileposts.recorded_on-lte': project_stage.end_on
      end

      @mileposts = Milepost.default_where(default_params)
      @projects = Project.includes(:project_taxon, :project_mileposts).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def new
      @project = Project.new(project_taxon_id: params[:project_taxon_id])
    end

    def create
      @project = Project.new(project_params)

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
        render 'update'
      else
        render :edit, locals: { model: @project }, status: :unprocessable_entity
      end
    end

    def sync
      @project.init_tasks
      @project.save
    end

    def destroy
      @project.destroy
    end

    private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_project_taxon
      if params[:project_taxon_id]
        @project_taxon = ProjectTaxon.find params[:project_taxon_id]
      elsif @project
        @project_taxon = @project.project_taxon
      end
    end

    def prepare_form
      @project_taxons = ProjectTaxon.default_where(default_params)
      @project_stages = ProjectStage.default_where(default_params)
    end

    def project_params
      p = params.fetch(:project, {}).permit(
        :name,
        :project_taxon_id,
        :budget,
        :description,
        :github_repo,
        extra: {}
      )
      p.merge! default_form_params
    end

  end
end
