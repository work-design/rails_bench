class Bench::Board::TasksController < Bench::Board::BaseController
  before_action :set_task, only: [
    :show,
    :edit,
    :update,
    :edit_focus,
    :update_focus,
    :project_id,
    :reorder,
    :next,
    :rework,
    :destroy
  ]
  default_form_builder nil

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing']
    }
    q_params.merge! default_params
    q_params.merge! params.permit(:focus, :state, :worker_id)
    @tasks = current_user.tasks.includes(:task_timer).roots.default_where(q_params).page(params[:page])
  end

  def new
    @task = Task.new(parent_id: params[:parent_id], project_id: params[:project_id])
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

    unless @task.save_with_parent
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
    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).where(project_id: @task.project_id).default_where(q_params).page(params[:page])
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

  def project_id
    @task.update_project_id(task_params[:project_id])
    render 'update'
  end

  def remove
    render 'update'
  end

  def edit_focus
    @task
  end

  def update_focus
    @task.update(focus: params[:focus])
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
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.fetch(:task, {}).permit(
      :project_id,
      :title,
      :content,
      :parent_id,
      :worker_id,
      :pipeline_id,
      :estimated_time
    )
  end
end
