module Bench
  class Panel::FacilitatesController < Panel::BaseController
    before_action :set_facilitate_taxons, only: [:index, :new, :edit]
    before_action :set_facilitate, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:facilitate_taxon_id)

      @facilitates = Facilitate.includes(:facilitate_taxon).default_where(q_params).page(params[:page])
    end

    private
    def set_facilitate_taxons
      @facilitate_taxons = FacilitateTaxon.all
    end

    def set_facilitate
      @facilitate = Facilitate.find(params[:id])
    end

    def facilitate_params
      params.fetch(:facilitate, {}).permit(
        :name,
        :description,
        :price,
        :logo,
        :facilitate_taxon_id
      )
    end

  end
end
