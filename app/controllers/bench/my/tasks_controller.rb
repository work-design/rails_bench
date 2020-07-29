class Bench::My::TasksController < Bench::My::BaseController
  before_action :set_task, only: [
    :show,
    :edit, :update, :edit_focus, :update_focus,
    :project_id, :reorder, :current, :next, :rework,
    :destroy
  ]
  before_action :require_worker, only: [:index]
  default_form_builder nil

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing'],
      user_id: current_user.id
    }
    if session[:present_worker] && current_worker
      q_params.merge! worker_id: current_worker.id
    end
    q_params.merge! params.permit(:focus, :state, :worker_id)
    @tasks = Task.includes(:task_timers).roots.default_where(q_params).page(params[:page])
  end

  def new
    @task = Task.new(raw_task_params)
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if session[:present_worker]
      @task.worker = current_user.present_worker
    end

    if task_params[:parent_id].present?
      redirect_to = my_task_url(task_params[:parent_id])
    elsif task_params[:parent_id].blank? && task_params[:project_id].present?
      redirect_to = tasks_my_project_url(task_params[:project_id])
    else
      redirect_to = my_tasks_url
    end

    if @task.save
      render 'create', locals: { return_to: redirect_to }
    else
      render :new, locals: { model: @task }, status: :unprocessable_entity
    end
  end

  def add
    if params[:task_id]
      @task = Task.find params[:task_id]
    else
      @task = Task.new
    end
  end

  def show
    q_params = {
      state: ['todo', 'doing'],
      user_id: current_user.id
    }
    q_params.merge! params.permit(:state, :focus)
    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).where(tasking_type: @task.tasking_type, tasking_id: @task.tasking_id).default_where(q_params).page(params[:page])
    render :show
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.integer? }

    if params[:new_index] > params[:old_index]
      prev_one = @task.same_scopes.find(sort_array[params[:new_index].to_i - 1])
      @task.insert_at prev_one.position
    else
      next_ones = @task.same_scopes.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
      next_ones.each do |next_one|
        next_one.insert_at @task.position
      end
    end
  end

  def edit
    @pipelines = @task.project.pipelines if params[:item] == 'pipeline'
  end

  def update
    @task.assign_attributes(task_params)

    if @task.save
      render :edit, locals: { model: @task }, status: :unprocessable_entity
    end
  end

  def remove
    render 'update'
  end

  def edit_focus
    @task
  end

  def next
    @task.set_next
    redirect_to my_task_url(@task)
  end

  def rework
    @task.set_rework
    redirect_to my_task_url(@task)
  end

  def destroy
    @task.destroy
  end

  private
  def require_worker
    case params[:present_worker]
    when '1'
      session[:present_worker] = true
    when '0'
      session[:present_worker] = false
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def raw_task_params
    params.permit(
      :parent_id,
      :tasking_type,
      :tasking_id
    )
  end

  def task_params
    p = params.fetch(:task, {}).permit(
      :tasking_type,
      :tasking_id,
      :title,
      :focus,
      :content,
      :parent_id,
      :member_id,
      :pipeline_id,
      :estimated_time
    )
    p.merge! default_form_params
  end
end
