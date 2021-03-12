module Bench
  class Admin::TaxonFacilitatesController < Admin::BaseController
    before_action :set_taxon
    before_action :set_taxon_facilitate, only: [:show, :edit, :update, :destroy, :new, :facilitates]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @taxon_facilitates = @taxon.taxon_facilitates.page(params[:page])
    end

    def new
      @facilitates = Facilitate.none
    end

    def create
      @taxon_facilitate = @taxon.taxon_facilitates.build(taxon_facilitate_params)

      unless @taxon_facilitate.save
        render :new, locals: { model: @taxon_facilitate }, status: :unprocessable_entity
      end
    end

    def facilitates
      q_params = {}
      q_params.merge! facilitate_taxon_id: taxon_facilitate_params[:facilitate_taxon_id]
      @facilitates = Facilitate.default_where(q_params)
    end

    def show
    end

    def edit
      @facilitates = Facilitate.default_where(facilitate_taxon_id: @taxon_facilitate.facilitate_taxon_id)
      @providers = @taxon_facilitate.facilitate.providers
    end

    def update
      @taxon_facilitate.assign_attributes(taxon_facilitate_params)

      unless @taxon_facilitate.save
        render :edit, locals: { model: @taxon_facilitate }, status: :unprocessable_entity
      end
    end

    def destroy
      @taxon_facilitate.destroy
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_taxon_facilitate
      if params[:id]
        @taxon_facilitate = @taxon.taxon_facilitates.find(params[:id])
      else
        @taxon_facilitate = @taxon.taxon_facilitates.build
      end
    end

    def prepare_form
      @facilitate_taxons = FacilitateTaxon.default_where(default_params)
    end

    def taxon_facilitate_params
      params.fetch(:taxon_facilitate, {}).permit(
        :facilitate_taxon_id,
        :facilitate_id
      )
    end

  end
end
