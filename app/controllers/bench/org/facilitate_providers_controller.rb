module Bench
  class Org::FacilitateProvidersController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_provider, only: [:show, :task_templates, :edit, :update, :destroy]

    def new
      @facilitate_provider = current_organ.facilitate_providers.build(facilitate_id: params[:facilitate_id])
    end

    def create
      @facilitate_provider = current_organ.facilitate_providers.build(facilitate_provider_params)
      @facilitate_provider.facilitate = @facilitate

      if @facilitate_provider.save
        render 'create'
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
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end


    def set_facilitate_provider
      @facilitate_provider = FacilitateProvider.find(params[:id])
    end

    def facilitate_provider_params
      params.fetch(:facilitate_provider, {}).permit(
        :facilitate_id,
        :export_price,
        :note
      )
    end

  end
end
