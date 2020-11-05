class Bench::Me::TasksController < Bench::Admin::TasksController
  include BenchController::Me

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing'],
    }
    q_params.merge! member_id: current_member.id
    q_params.merge! params.permit(:focus, :state, :tasking_type, :tasking_id)
    @tasks = Task.includes(:task_timers).roots.default_where(q_params).page(params[:page])
  end

  def create
    @task = current_member.tasks.build task_params

    if @task.save
      render 'create'
    else
      render :new, locals: { model: @task }, status: :unprocessable_entity
    end
  end

  def show
    q_params = {
      user_id: current_user.id
    }
    q_params.merge! params.permit(:state, :focus)

    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
  end

end
