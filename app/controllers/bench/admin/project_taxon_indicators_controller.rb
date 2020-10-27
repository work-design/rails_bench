class Bench::Admin::ProjectTaxonIndicatorsController < Bench::Admin::BaseController
  before_action :set_project_taxon
  before_action :set_project_taxon_indicator, only: [:show, :edit, :update, :destroy]

  def index
    @project_taxon_indicators = ProjectTaxonIndicator.page(params[:page])
  end

  def new
    @project_taxon_indicator = ProjectTaxonIndicator.new
  end

  def create
    @project_taxon_indicator = ProjectTaxonIndicator.new(project_taxon_indicator_params)

    unless @project_taxon_indicator.save
      render :new, locals: { model: @project_taxon_indicator }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_taxon_indicator.assign_attributes(project_taxon_indicator_params)

    unless @project_taxon_indicator.save
      render :edit, locals: { model: @project_taxon_indicator }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_taxon_indicator.destroy
  end

  private
  def set_project_taxon
    @project_taxon = ProjectTaxon.find params[:project_taxon_id]
  end

  def set_project_taxon_indicator
    @project_taxon_indicator = ProjectTaxonIndicator.find(params[:id])
  end

  def project_taxon_indicator_params
    params.fetch(:project_taxon_indicator, {}).permit(
      :facilitate_taxon_id,
      :indicator_id
    )
  end

end
