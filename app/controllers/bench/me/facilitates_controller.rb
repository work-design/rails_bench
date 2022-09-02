module Bench
  class Me::FacilitatesController < Admin::BaseController
    include Controller::Me
    before_action :set_facilitate, only: [:show, :order]
    before_action :set_facilitate_taxons, only: [:index]

    def index
      q_params = {}
      q_params.merge! params.permit(:facilitate_taxon_id)

      @facilitates = current_member.facilitaties.default_where(q_params).page(params[:page])
    end

    def order
      @facilitate.generate_order!(user: current_user)
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
