module Bench
  class FacilitatesController < BaseController
    before_action :set_facilitate, only: [:show]
    before_action :set_facilitate_taxons, only: [:index, :buy]

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitates = Facilitate.default_where(q_params).page(params[:page])
    end

    def buy
      q_params = {}
      q_params.merge! default_params

      @facilitates = Facilitate.default_where(q_params).page(params[:page])
    end

    def order
    end

    private
    def set_facilitate_taxons
      q_params = {}
      q_params.merge! default_params

      @facilitate_taxons = FacilitateTaxon.default_where(q_params)
    end

    def set_facilitate
      @facilitate = Facilitate.find(params[:id])
    end

    def facilitate_params
      params.fetch(:facilitate, {})
    end

  end
end
