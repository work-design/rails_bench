module Bench
  class Panel::TaxonIndicatorsController < Panel::BaseController
    before_action :set_taxon
    before_action :set_taxon_indicator, only: [:show, :edit, :update, :destroy]
    before_action :set_facilitate_taxons, only: [:new, :edit]

    def index
      @taxon_indicators = @taxon.taxon_indicators.page(params[:page])
    end

    def new
      @indicators = Indicator.none
      @taxon_indicator = @taxon.taxon_indicators.build
    end

    def create
      @taxon_indicator = @taxon.taxon_indicators.build(taxon_indicator_params)

      unless @taxon_indicator.save
        render :new, locals: { model: @taxon_indicator }, status: :unprocessable_entity
      end
    end

    def edit
      @indicators = @taxon_indicator.facilitate_taxon.indicators
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

    def set_facilitate_taxons
      @facilitate_taxons = FacilitateTaxon.default_where(default_params)
    end

    def taxon_indicator_params
      params.fetch(:taxon_indicator, {}).permit(
        :facilitate_taxon_id,
        :indicator_id
      )
    end

  end
end
