module Bench
  class Panel::FacilitateIndicatorsController < Panel::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_indicator, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form

    def index
      @facilitate_indicators = @facilitate.facilitate_indicators.page(params[:page])
    end

    def new
      @facilitate_indicator = @facilitate.facilitate_indicators.build
    end

    def create
      @facilitate_indicator = @facilitate.facilitate_indicators.build(facilitate_indicator_params)

      unless @facilitate_indicator.save
        render :new, locals: { model: @facilitate_indicator }, status: :unprocessable_entity
      end
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end

    def set_facilitate_indicator
      @facilitate_indicator = @facilitate.facilitate_indicators.find params[:id]
    end

    def prepare_form
      @indicators = @facilitate.facilitate_taxon.indicators.where.not(id: @facilitate.indicator_ids)
    end

    def facilitate_indicator_params
      params.fetch(:facilitate_indicator, {}).permit(
        :note,
        :indicator_id
      )
    end

  end
end
