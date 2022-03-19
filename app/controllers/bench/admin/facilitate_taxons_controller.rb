module Bench
  class Admin::FacilitateTaxonsController < Admin::BaseController
    before_action :set_facilitate_taxon, only: [:edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @facilitate_taxons = FacilitateTaxon.default_where(q_params).page(params[:page])
    end

    def new
      @facilitate_taxon = FacilitateTaxon.new
    end

    def create
      @facilitate_taxon = FacilitateTaxon.new(facilitate_taxon_params)

      if @facilitate_taxon.save
        render 'create'
      else
        render action: 'new', locals: { model: @facilitate_taxon }, status: :unprocessable_entity
      end
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
