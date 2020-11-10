class Bench::Me::TasksController < Bench::Admin::TasksController
  include BenchController::Me

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing'],
      member_id: current_member.id
    }
    q_params.merge! params.permit(:focus, :state, :project_id)

    @tasks = Task.includes(:project, :task_timers).default_where(q_params).page(params[:page])
  end

  def project
    q_params = {
      member_id: current_member.id
    }
    q_params.merge! params.permit(:state)

    @project = Project.find params[:project_id]
    @tasks = @project.tasks.default_where(q_params)
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
      member_id: current_member.id
    }
    q_params.merge! params.permit(:state, :focus)

    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
  end


end
