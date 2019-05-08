class Bench::Admin::DutiesController < Bench::Admin::BaseController
  before_action :set_duty, only: [:show, :edit, :update, :destroy]

  def index
    @duties = Duty.all.page(params[:page])
  end

  def show
  end

  def new
    @duty = Duty.new
  end

  def edit
  end

  def create
    @duty = Duty.new(duty_params)

    respond_to do |format|
      if @duty.save
        format.html { redirect_to admin_duties_url, notice: 'Duty was successfully created.' }
        format.json { render :show, status: :created, location: @duty }
      else
        format.html { render :new }
        format.json { render json: @duty.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @duty.update(duty_params)
        format.html { redirect_to admin_duties_url, notice: 'Duty was successfully updated.' }
        format.json { render :show, status: :ok, location: @duty }
      else
        format.html { render :edit }
        format.json { render json: @duty.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @duty.destroy
    respond_to do |format|
      format.html { redirect_to admin_duties_url, notice: 'Duty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_duty
    @duty = Duty.find(params[:id])
  end

  def duty_params
    params.fetch(:duty, {}).permit(
      :name,
      :description
    )
  end

end
