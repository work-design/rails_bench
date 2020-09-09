class Bench::Admin::ProjectTaxonsController < Bench::Admin::BaseController
  before_action :set_project_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @project_taxons = ProjectTaxon.page(params[:page])
  end

  def new
    @project_taxon = ProjectTaxon.new
  end

  def create
    @project_taxon = ProjectTaxon.new(project_taxon_params)

    unless @project_taxon.save
      render :new, locals: { model: @project_taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_taxon.assign_attributes(project_taxon_params)

    unless @project_taxon.save
      render :edit, locals: { model: @project_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_taxon.destroy
  end

  private
  def set_project_taxon
    @project_taxon = ProjectTaxon.find(params[:id])
  end

  def project_taxon_params
    params.fetch(:project_taxon, {}).permit(
      :name
    )
  end

end
