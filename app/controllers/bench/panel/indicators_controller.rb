module Bench
  class Panel::IndicatorsController < Panel::BaseController
    before_action :set_facilitate_taxons, except: [:destroy]
    before_action :set_new_indicator, only: [:new, :create]
    before_action :set_indicator, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:facilitate_taxon_id, 'name-like')

      @indicators = Indicator.default_where(q_params).page(params[:page])
    end

    private
    def set_indicator
      @indicator = Indicator.find params[:id]
    end

    def set_new_indicator
      @indicator = Indicator.new(indicator_params)
    end

    def set_facilitate_taxons
      @facilitate_taxons = FacilitateTaxon.all
    end

    def indicator_params
      params.fetch(:indicator, {}).permit(
        :name,
        :description,
        :facilitate_taxon_id,
        :indicator_value,
        :unit,
        :reference_min,
        :reference_max,
        :indicator_source
      )
    end

  end
end
