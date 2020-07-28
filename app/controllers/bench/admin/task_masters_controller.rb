class Bench::Admin::TaskMastersController < Bench::Admin::BaseController
  before_action :set_task_master, only: [:show, :edit, :update, :destroy]
  before_action :set_members

  def index
    @task_masters = TaskMaster.page(params[:page])
  end

  def new
    @task_master = TaskMaster.new
  end

  def create
    @task_master = TaskMaster.new(task_master_params)

    unless @task_master.save
      render :new, locals: { model: @task_master }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @task_master.assign_attributes(task_master_params)

    unless @task_master.save
      render :edit, locals: { model: @task_master }, status: :unprocessable_entity
    end
  end

  def destroy
    @task_master.destroy
  end

  private
  def set_task_master
    @task_master = TaskMaster.find(params[:id])
  end

  def set_members
    q_params = {}
    q_params.merge! default_params
    @members = Member.default_where(q_params)
  end

  def task_master_params
    params.fetch(:task_master, {}).permit(
      :tasking_type,
      :member_id
    )
  end

end
