class Bench::Me::TasksController < Bench::Me::BaseController
  before_action :set_task, only: [
    :show, :edit, :update, :edit_focus, :edit_assign, :reorder, :edit_done, :update_done, :rework, :destroy
  ]

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing'],
      user_id: current_user.id
    }
    q_params.merge! member_id: current_member.id if current_member
    q_params.merge! params.permit(:focus, :state, :tasking_type, :tasking_id)
    @tasks = Task.includes(:task_timers).roots.default_where(q_params).page(params[:page])
  end

  def new
    @task = Task.new(raw_task_params)
  end

  def create
    @task = Task.new(task_params)
    @task.member_id ||= current_member.id

    if task_params[:parent_id].present?
      redirect_to = me_task_url(task_params[:parent_id])
    elsif task_params[:parent_id].blank? && task_params[:tasking_type] == 'Project'
      redirect_to = tasks_me_project_url(task_params[:tasking_id])
    else
      redirect_to = me_tasks_url
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
      user_id: current_user.id
    }
    q_params.merge! params.permit(:state, :focus)

    @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
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
  end

  def edit_assign
    q_params = {
      'member_departments.job_title_id': @task.job_title_id
    }
    q_params.merge! default_params
    @members = Member.default_where(q_params)
  end

  def update
    @task.assign_attributes(task_params)

    unless @task.save
      render :edit, locals: { model: @task }, status: :unprocessable_entity
    end
  end

  def remove
    render 'update'
  end

  def edit_focus
    @task
  end

  def edit_done
  end

  def update_done
    @task.assign_attributes(task_params)
    @task.done_at = Time.current

    unless @task.save
      render :edit_done, locals: { model: @task }, status: :unprocessable_entity
    end
  end

  def rework
    @task.set_rework
  end

  def destroy
    @task.destroy
  end

  private
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
      :task_template_id,
      :estimated_time,
      :note,
      :done_at,
      :proof
    )
    p.merge! default_form_params
  end

end
