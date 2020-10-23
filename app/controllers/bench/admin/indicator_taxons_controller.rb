class Bench::Admin::IndicatorTaxonsController < Bench::Admin::BaseController

  def new
    @indicator_taxon = IndicatorTaxon.new
  end

  def create
    @indicator_taxon = IndicatorTaxon.new(indicator_taxon_params)

    if @indicator_taxon.save
      render 'create'
    else
      render action: 'new', locals: { model: @indicator_taxon }, status: :unprocessable_entity
    end
  end

  private
  def indicator_taxon_params
    p = params.fetch(:indicator_taxon, {}).permit(
      :name,
      :color
    )
    p.merge! default_form_params
  end
end
