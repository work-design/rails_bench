class Bench::Admin::ProjectPreferencesController < Bench::Admin::BaseController
  before_action :set_project_taxon
  before_action :set_project_preference, only: [:show, :edit, :update, :destroy, :new, :facilitates, :providers]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @project_preferences = @project_taxon.project_preferences.page(params[:page])
  end

  def new
    @facilitates = Facilitate.none
    @providers = Organ.none
  end

  def create
    @project_preference = @project_taxon.project_preferences.build(project_preference_params)

    unless @project_preference.save
      render :new, locals: { model: @project_preference }, status: :unprocessable_entity
    end
  end

  def facilitates
    q_params = {}
    q_params.merge! facilitate_taxon_id: project_preference_params[:facilitate_taxon_id]
    @facilitates = Facilitate.default_where(q_params)
  end

  def providers
    @facilitate = Facilitate.find project_preference_params[:facilitate_id]
    @providers = @facilitate.providers
  end

  def show
  end

  def edit
    @facilitates = Facilitate.default_where(facilitate_taxon_id: @project_preference.facilitate_taxon_id)
    @providers = @project_preference.facilitate.providers
  end

  def update
    @project_preference.assign_attributes(project_preference_params)

    unless @project_preference.save
      render :edit, locals: { model: @project_preference }, status: :unprocessable_entity
    end
  end

  def destroy
    @project_preference.destroy
  end

  private
  def set_project_taxon
    @project_taxon = ProjectTaxon.find params[:project_taxon_id]
  end

  def set_project_preference
    if params[:id]
      @project_preference = @project_taxon.project_preferences.find(params[:id])
    else
      @project_preference = @project_taxon.project_preferences.build
    end
  end

  def prepare_form
    @facilitate_taxons = FacilitateTaxon.all
  end

  def project_preference_params
    params.fetch(:project_preference, {}).permit(
      :facilitate_taxon_id,
      :facilitate_id,
      :provider_id
    )
  end

end
