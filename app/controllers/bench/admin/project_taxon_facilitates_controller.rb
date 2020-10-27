class Bench::Admin::ProjectTaxonFacilitatesController < Bench::Admin::BaseController
  before_action :set_project_taxon
  before_action :set_project_taxon_facilitate, only: [:show, :edit, :update, :destroy, :new, :facilitates, :providers]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @project_taxon_facilitates = @project_taxon.project_taxon_facilitates.page(params[:page])
  end

  def new
    @facilitates = Facilitate.none
  end

  def create
    @project_taxon_facilitate = @project_taxon.project_taxon_facilitates.build(project_taxon_facilitate_params)

    unless @project_taxon_facilitate.save
      render :new, locals: { model: @project_taxon_facilitate }, status: :unprocessable_entity
    end
  end

  def facilitates
    q_params = {}
    q_params.merge! facilitate_taxon_id: project_taxon_facilitate_params[:facilitate_taxon_id]
    @facilitates = Facilitate.default_where(q_params)
  end

  def show
  end

  def edit
    @facilitates = Facilitate.default_where(facilitate_taxon_id: @project_taxon_facilitate.facilitate_taxon_id)
    @providers = @project_taxon_facilitate.facilitate.providers
  end

  def update
    @project_taxon_facilitate.assign_attributes(project_taxon_facilitate_params)

    unless @project_taxon_facilitate.save
      render :edit, locals: { model: @project_taxon_facilitate }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_taxon_facilitate.destroy
  end

  private
  def set_project_taxon
    @project_taxon = ProjectTaxon.find params[:project_taxon_id]
  end

  def set_project_taxon_facilitate
    if params[:id]
      @project_taxon_facilitate = @project_taxon.project_taxon_facilitates.find(params[:id])
    else
      @project_taxon_facilitate = @project_taxon.project_taxon_facilitates.build
    end
  end

  def prepare_form
    @facilitate_taxons = FacilitateTaxon.default_where(default_params)
  end

  def project_taxon_facilitate_params
    params.fetch(:project_taxon_facilitate, {}).permit(
      :facilitate_taxon_id,
      :facilitate_id
    )
  end

end
