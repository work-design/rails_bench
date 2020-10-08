class Bench::Admin::ProjectPreferencesController < Bench::Admin::BaseController
  before_action :set_project_taxon
  before_action :set_project_preference, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new]

  def index
    @project_preferences = ProjectPreference.page(params[:page])
  end

  def new
    @project_preference = ProjectPreference.new
  end

  def create
    @project_preference = ProjectPreference.new(project_preference_params)

    unless @project_preference.save
      render :new, locals: { model: @project_preference }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
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
    @project_preference = ProjectPreference.find(params[:id])
  end

  def prepare_form
    @facilitate_taxons = FacilitateTaxon.all
  end

  def project_preference_params
    params.fetch(:project_preference, {}).permit(
      :facilitate_id,
      :provider_id
    )
  end

end
