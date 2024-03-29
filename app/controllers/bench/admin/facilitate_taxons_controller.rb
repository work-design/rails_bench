module Bench
  class Admin::FacilitateTaxonsController < Admin::BaseController
    before_action :set_facilitate_taxon, only: [:edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name)

      @facilitate_taxons = FacilitateTaxon.default_where(q_params).page(params[:page])
    end

    private
    def set_facilitate_taxon
      @facilitate_taxon = FacilitateTaxon.find params[:id]
    end

    def facilitate_taxon_params
      p = params.fetch(:facilitate_taxon, {}).permit(
        :name,
        :color
      )
      p.merge! default_form_params
    end

  end
end
