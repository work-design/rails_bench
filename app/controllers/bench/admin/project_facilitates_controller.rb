class Bench::Admin::ProjectFacilitatesController < Bench::Admin::BaseController
  before_action :set_project
  before_action :set_project_facilitate, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @project_facilitates = @project.project_facilitates.page(params[:page])
  end

  def new
    @project_facilitate = @project.project_facilitates.new
  end

  def create
    @project_facilitate = @project.project_facilitates.new(project_facilitate_params)

    unless @project_facilitate.save
      logger.info(@project_facilitate.errors.full_messages)
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

  # slect options
  def facilitates
    q_params = {}
    q_params.merge! facilitate_taxon_id: project_facilitate_params[:facilitate_taxon_id]
    @facilitates = Facilitate.default_where(q_params)
  end

  def providers
    @facilitate = Facilitate.find project_facilitate_params[:facilitate_id]
    @providers = @facilitate.providers
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
      :facilitate_taxon_id,
      :facilitate_id,
      :provider_id
    )
  end

  def prepare_form
    @facilitate_taxons = FacilitateTaxon.limit(500)
    @facilitates = Facilitate.limit(500)
    @providers = @project_facilitate&.facilitate&.providers || []
  end

end
