module Bench
  class Org::FacilitatesController < Admin::BaseController
    before_action :set_facilitate, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:facilitate_taxon_id)

      @facilitate_providers = FacilitateProvider.default_where(default_params).page(params[:page])
      @facilitates = Facilitate.default_where(q_params).page(params[:page])
    end

    def show
    end

    def new
      @facilitate = Facilitate.new
    end

    def edit
    end

    def create
      @facilitate = Facilitate.new(facilitate_params)

      unless @facilitate.save
        render :new, locals: { model: @facilitate }, status: :unprocessable_entity
      end
    end

    def update
      @facilitate.assign_attributes facilitate_params

      unless @facilitate.save
        render :edit, locals: { model: @facilitate }, status: :unprocessable_entity
      end
    end

    def destroy
      @facilitate.destroy
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find(params[:id])
    end

    def facilitate_params
      p = params.fetch(:facilitate, {}).permit(
        :name,
        :description,
        :price,
        :logo,
        :facilitate_taxon_id
      )
      p.merge! default_form_params
    end

  end
end
