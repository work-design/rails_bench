module Bench
  class Admin::IndicatorsController < Admin::BaseController
    before_action :pre_form, except: [:destroy]
    before_action :set_indicator, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:facilitate_taxon_id, 'name-like')

      @indicators = Indicator.default_where(q_params).page(params[:page])
    end

    def new
      @indicator = Indicator.new
    end

    def create
      @indicator = Indicator.new(indicator_params)

      if @indicator.save
        render 'create'
      else
        render action: 'new', locals: { model: @indicator }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @indicator.assign_attributes(indicator_params)

      if @indicator.save
        render 'update'
      else
        render action: 'edit', locals: { model: @indicator }, status: :unprocessable_entity
      end
    end

    def destroy
      @indicator.destroy
    end

    private
    def set_indicator
      @indicator = Indicator.find params[:id]
    end

    def pre_form
      @facilitate_taxons = FacilitateTaxon.default_where(default_params)
    end

    def indicator_params
      p = params.fetch(:indicator, {}).permit(
        :name,
        :description,
        :facilitate_taxon_id,
        :indicator_value,
        :unit,
        :indicator_source
      )
      p.merge! default_form_params
    end

  end
end
