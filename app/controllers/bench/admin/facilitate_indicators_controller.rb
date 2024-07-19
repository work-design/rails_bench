module Bench
  class Admin::FacilitateIndicatorsController < Admin::BaseController
    before_action :set_facilitate
    before_action :set_facilitate_indicator, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_facilitate_indicator, only: [:new, :create]
    before_action :set_indicators

    def index
      @facilitate_indicators = @facilitate.facilitate_indicators.page(params[:page])
    end

    private
    def set_facilitate
      @facilitate = Facilitate.find params[:facilitate_id]
    end

    def set_facilitate_indicator
      @facilitate_indicator = @facilitate.facilitate_indicators.find params[:id]
    end

    def set_new_facilitate_indicator
      @facilitate_indicator = @facilitate.facilitate_indicators.build(facilitate_indicator_params)
    end

    def set_indicators
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
