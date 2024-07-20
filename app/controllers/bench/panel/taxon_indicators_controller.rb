module Bench
  class Panel::TaxonIndicatorsController < Panel::BaseController
    before_action :set_taxon
    before_action :set_taxon_indicator, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_taxon_indicator, only: [:new, :create]
    before_action :set_indicators, only: [:new, :create, :edit, :update]

    def index
      @taxon_indicators = @taxon.taxon_indicators.page(params[:page])
    end

    def indicators
      q_params = {}
      q_params.merge! facilitate_taxon_id: taxon_indicator_params[:facilitate_taxon_id]

      @indicators = Indicator.default_where(q_params)
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_taxon_indicator
      @taxon_indicator = @taxon.taxon_indicators.find(params[:id])
    end

    def set_new_taxon_indicator
      @taxon_indicator = @taxon.taxon_indicators.build(taxon_indicator_params)
    end

    def set_indicators
      @indicators = Indicator.where.not(id: @taxon.taxon_indicators.pluck(:indicator_id))
    end

    def taxon_indicator_params
      params.fetch(:taxon_indicator, {}).permit(
        :indicator_id,
        :weight
      )
    end

  end
end
