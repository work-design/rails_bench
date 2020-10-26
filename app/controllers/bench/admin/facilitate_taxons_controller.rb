class Bench::Admin::FacilitateTaxonsController < Bench::Admin::BaseController
  before_action :set_facilitate_taxon, only: [:edit, :update, :destroy]

  def new
    @facilitate_taxon = FacilitateTaxon.new
  end

  def edit
  end

  def create
    @facilitate_taxon = FacilitateTaxon.new(facilitate_taxon_params)

    if @facilitate_taxon.save
      render 'create'
    else
      render action: 'new', locals: { model: @facilitate_taxon }, status: :unprocessable_entity
    end
  end

  def update
    @facilitate_taxon.assign_attributes(facilitate_taxon_params)

    if @facilitate_taxon.save
      render 'update'
    else
      render action: 'edit', locals: { model: @facilitate_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @facilitate_taxon.destroy
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
