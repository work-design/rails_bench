class Bench::My::TasksController < Bench::My::BaseController
  before_action :set_task, only: [
    :show,
    :edit,
    :update,
    :edit_focus,
    :update_focus,
    :project_id,
    :reorder,
    :current,
    :next,
    :rework,
    :destroy
  ]
  before_action :require_worker, only: [:index]
  default_form_builder nil

  def index
    q_params = {
      focus: ['today'],
      state: ['todo', 'doing'],
      user_id: current_user.id
    }
    if session[:present_worker] && current_worker
      q_params.merge! worker_id: current_worker.id
    end
    q_params.merge! params.permit(:focus, :state, :worker_id)
    @tasks = Task.includes(:project, :task_timer).roots.default_where(q_params).page(params[:page])
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

    respond_to do |format|
      if @task.save_with_parent
        format.js
        format.html {
          if task_params[:parent_id].present?
            redirect_to my_task_url(task_params[:parent_id])
          elsif task_params[:parent_id].blank? && task_params[:project_id].present?
            redirect_to tasks_my_project_url(task_params[:project_id])
          else
            redirect_to my_tasks_url
          end
        }
        format.json
      else
        format.js
        format.html { render :new }
        format.json
      end
    end
  end

  def show
    q_params = {
      state: ['todo', 'doing'],
      user_id: current_user.id
    }.with_indifferent_access
    q_params.merge! params.permit(:state, :focus)
    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).where(project_id: @task.project_id).default_where(q_params).page(params[:page])
    render :show, layout: 'application'
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.to_i.to_s == i }

    if params[:new_index] > params[:old_index]
      prev_one = @task.same_scopes.find(sort_array[params[:new_index].to_i - 1])
      @task.insert_at prev_one.position
    else
      next_ones = @task.same_scopes.find(sort_array[(params[:new_index] + 1)..params[:old_index]])
      next_ones.each do |next_one|
        next_one.insert_at @task.position
      end
    end

    render json: @task.as_json
  end

  def edit
    @pipelines = @task.project.pipelines if params[:item] == 'pipeline'
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: 'Task was successfully updated.' }
        format.js { render 'update' }
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def project_id
    @task.update_project_id(task_params[:project_id])
    render 'update'
  end

  def remove
    render 'update'
  end

  def current
    @task.set_current(params[:worker_id])
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
    respond_to do |format|
      format.html { redirect_to my_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
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
