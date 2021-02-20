module Bench
  class Admin::ProjectTaxonsController < Admin::BaseController
    before_action :set_project_taxon, only: [:show, :edit, :parameter, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @project_taxons = ProjectTaxon.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      @project_taxon = ProjectTaxon.new
    end

    def create
      @project_taxon = ProjectTaxon.new(project_taxon_params)

      unless @project_taxon.save
        render :new, locals: { model: @project_taxon }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def parameter
    end

    def update
      @project_taxon.assign_attributes(project_taxon_params)

      unless @project_taxon.save
        render :edit, locals: { model: @project_taxon }, status: :unprocessable_entity
      end
    end

    def destroy
      @project_taxon.destroy
    end

    private
    def set_project_taxon
      @project_taxon = ProjectTaxon.find(params[:id])
    end

    def project_taxon_params
      result = params.fetch(:project_taxon, {}).permit(
        :name,
        parameters: [:column, :value]  #todo key is original method of hash
      )

      _params = result['parameters']&.values&.map { |i|  {i['column'] => i['value'] } }
      _params = Array(_params).to_combine_h
      result['parameters'] = _params
      result.merge! default_form_params
    end

  end
end
