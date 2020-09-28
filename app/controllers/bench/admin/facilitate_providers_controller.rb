class Bench::Admin::FacilitateProvidersController < Bench::Admin::BaseController
  before_action :set_facilitate_provider, only: [:show, :task_templates, :edit, :update, :destroy]

  def index
    @facilitate_providers = current_organ.facilitate_providers
  end

  def new
    @facilitate_provider = current_organ.facilitate_providers.build(facilitate_id: params[:facilitate_id])
  end

  def create
    @facilitate_provider = current_organ.facilitate_providers.build(facilitate_provider_params)

    if @facilitate_provider.save
      render 'create', locals: { return_to: me_facilitate_providers_url }
    else
      render :new, locals: { model: @facilitate_provider }, status: :unprocessable_entity
    end
  end

  def show
  end

  def task_templates
    @task_templates = @facilitate_provider.task_templates
  end

  def edit
  end

  def update
    @facilitate_provider.assign_attributes(facilitate_provider_params)

    unless @facilitate_provider.save
      render :edit, locals: { model: @facilitate_provider }, status: :unprocessable_entity
    end
  end

  def destroy
    @facilitate_provider.destroy
  end

  private
  def set_facilitate_provider
    @facilitate_provider = FacilitateProvider.find(params[:id])
  end

  def facilitate_provider_params
    params.fetch(:facilitate_provider, {}).permit(
      :facilitate_id,
      :note
    )
  end

  def task_template_params
    params.fetch(:task_template, {}).permit(
      :name,
      :description
    )
  end

end
