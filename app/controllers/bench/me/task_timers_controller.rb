class Bench::Me::TaskTimersController < Bench::Me::BaseController
  before_action :set_task
  before_action :set_task_timer, only: [:show, :edit, :update, :pause, :destroy]

  def index
    q_params = {
      state: ['todo', 'doing'],
      focus: 'today',
      user_id: current_user.id
    }
    q_params.merge! params.permit(:state)
    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
    @task_timers = @task.task_timers.order(id: :desc)
  end

  def show
  end

  def new
    @task_timer = @task.task_timers.build
  end

  def edit
  end

  def create
    @task_timer = @task.task_timers.build(task_timer_params)

    unless @task_timer.save
      render :new
    end
  end

  def pause
    if @task_timer.pause
      render 'pause'
    else
      render :edit
    end
  end

  def update
    @task_timer.assign_attributes(task_timer_params)

    unless @task_timer.save
      render :edit
    end
  end

  def destroy
    @task_timer.destroy
  end

  private
  def set_task
    @task = Task.find params[:task_id]
  end

  def set_task_timer
    @task_timer = TaskTimer.find(params[:id])
  end

  def task_timer_params
    params.fetch(:task_timer, {})
  end

end
