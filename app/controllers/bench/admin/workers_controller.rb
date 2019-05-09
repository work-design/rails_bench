class Bench::Admin::WorkersController < Bench::Admin::BaseController
  before_action :set_worker, only: [:show, :edit, :update, :edit_user, :update_user, :destroy]

  def index
    @workers = Worker.page(params[:page])
  end

  def search
    @workers = Worker.where(real_name: params[:q])

    results = @workers.as_json(only: [:id, :name])
    render json: { results: results }
  end

  def new
    @worker = Worker.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to admin_workers_url }
        format.js
      else
        format.html { redirect_to admin_workers_url, error: @worker.errors }
        format.js
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @worker.assign_attributes(worker_params)
    respond_to do |format|
      if @worker.save
        format.html { redirect_to admin_workers_url }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def edit_user

  end

  def update_user
    if params[:login].include?('@')
      user = User.find_by(email: params[:login])
    else
      user = User.find_by(mobile: params[:login])
    end

    respond_to do |format|
      if @worker.update(user_id: user&.id)
        format.html { redirect_to admin_workers_url }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to admin_workers_url }
      format.json { head :no_content }
    end
  end

  private
  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.fetch(:worker, {}).permit(
      :title,
      :name,
      :grade,
      :join_on,
      :disabled,
      :who_id
    )
  end

end
