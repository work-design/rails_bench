module Bench
  class Panel::TaxonFacilitatesController < Panel::BaseController
    before_action :set_taxon
    before_action :set_taxon_facilitate, only: [:show, :edit, :update, :destroy, :facilitates]
    before_action :set_new_taxon_facilitate, only: [:new, :create]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @taxon_facilitates = @taxon.taxon_facilitates.page(params[:page])
    end

    def new
      @facilitates = Facilitate.none
    end

    def facilitates
      q_params = {}
      q_params.merge! facilitate_taxon_id: taxon_facilitate_params[:facilitate_taxon_id]
      @facilitates = Facilitate.default_where(q_params)
    end

    def edit
      @facilitates = Facilitate.default_where(facilitate_taxon_id: @taxon_facilitate.facilitate_taxon_id)
      @providers = @taxon_facilitate.facilitate.providers
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_taxon_facilitate
      @taxon_facilitate = @taxon.taxon_facilitates.find(params[:id])
    end

    def set_new_taxon_facilitate
      @taxon_facilitate = @taxon.taxon_facilitates.build(taxon_facilitate_params)
    end

    def taxon_facilitate_params
      params.fetch(:taxon_facilitate, {}).permit(
        :facilitate_id
      )
    end

  end
end
