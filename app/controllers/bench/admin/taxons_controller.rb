module Bench
  class Admin::TaxonsController < Admin::BaseController
    before_action :set_taxon, only: [:show, :budgets, :expenses, :edit, :parameter, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @taxons = Taxon.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      @taxon = Taxon.new
    end

    def create
      @taxon = Taxon.new(taxon_params)

      unless @taxon.save
        render :new, locals: { model: @taxon }, status: :unprocessable_entity
      end
    end

    def budgets
      @budgets = @taxon.budgets.page(params[:page])
    end

    def expenses
    end

    def parameter
    end

    private
    def set_taxon
      @taxon = Taxon.find(params[:id])
    end

    def taxon_params
      result = params.fetch(:taxon, {}).permit(
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
