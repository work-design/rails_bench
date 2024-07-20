module Bench
  class Panel::TaxonsController < Panel::BaseController
    before_action :set_taxon, only: [:show, :budgets, :expenses, :edit, :parameter, :update, :destroy]
    before_action :set_new_taxon, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @taxons = Taxon.default_where(q_params).order(id: :asc).page(params[:page])
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

    def set_new_taxon
      @taxon = Taxon.new(taxon_params)
    end

    def taxon_params
      result = params.fetch(:taxon, {}).permit(
        :name,
        parameters: [:column, :value]  #todo key is original method of hash
      )

      _params = result['parameters']&.values&.map { |i|  {i['column'] => i['value'] } }
      _params = Array(_params).to_combine_h
      result['parameters'] = _params
      result
    end

  end
end
