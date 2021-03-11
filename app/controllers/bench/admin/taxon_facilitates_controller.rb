module Bench
  class Admin::TaxonFacilitatesController < Admin::BaseController
    before_action :set_project_taxon
    before_action :set_taxon_indicators, only: [:show, :edit, :update, :destroy, :new, :facilitates]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @taxon_indicatorss = @project_taxon.taxon_indicatorss.page(params[:page])
    end

    def new
      @facilitates = Facilitate.none
    end

    def create
      @taxon_indicators = @project_taxon.taxon_indicatorss.build(taxon_indicators_params)

      unless @taxon_indicators.save
        render :new, locals: { model: @taxon_indicators }, status: :unprocessable_entity
      end
    end

    def facilitates
      q_params = {}
      q_params.merge! facilitate_taxon_id: taxon_indicators_params[:facilitate_taxon_id]
      @facilitates = Facilitate.default_where(q_params)
    end

    def show
    end

    def edit
      @facilitates = Facilitate.default_where(facilitate_taxon_id: @taxon_indicators.facilitate_taxon_id)
      @providers = @taxon_indicators.facilitate.providers
    end

    def update
      @taxon_indicators.assign_attributes(taxon_indicators_params)

      unless @taxon_indicators.save
        render :edit, locals: { model: @taxon_indicators }, status: :unprocessable_entity
      end
    end

    def destroy
      @taxon_indicators.destroy
    end

    private
    def set_project_taxon
      @project_taxon = ProjectTaxon.find params[:project_taxon_id]
    end

    def set_taxon_indicators
      if params[:id]
        @taxon_indicators = @project_taxon.taxon_indicatorss.find(params[:id])
      else
        @taxon_indicators = @project_taxon.taxon_indicatorss.build
      end
    end

    def prepare_form
      @facilitate_taxons = FacilitateTaxon.default_where(default_params)
    end

    def taxon_indicators_params
      params.fetch(:taxon_indicators, {}).permit(
        :facilitate_taxon_id,
        :facilitate_id
      )
    end

  end
end
