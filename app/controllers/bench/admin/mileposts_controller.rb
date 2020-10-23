class Bench::Admin::MilepostsController < Bench::Admin::BaseController
  before_action :set_milepost, only: [:show, :edit, :update, :destroy]

  def index
    @mileposts = Milepost.page(params[:page])
  end

  def new
    @milepost = Milepost.new
  end

  def create
    @milepost = Milepost.new(milepost_params)

    unless @milepost.save
      render :new, locals: { model: @milepost }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @milepost.assign_attributes(milepost_params)

    unless @milepost.save
      render :edit, locals: { model: @milepost }, status: :unprocessable_entity
    end
  end

  def destroy
    @milepost.destroy
  end

  private
  def set_milepost
    @milepost = Milepost.find(params[:id])
  end

  def milepost_params
    params.fetch(:milepost, {}).permit(
      :name,
      :project_mileposts_count
    )
  end

end
