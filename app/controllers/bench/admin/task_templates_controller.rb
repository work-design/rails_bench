class Bench::Admin::TaskTemplatesController < Bench::Admin::BaseController
  before_action :set_task_template, only: [:show, :edit, :update, :reorder, :destroy]
  default_form_builder nil

  def index
    q_params = {}
    q_params.merge! default_params
    @task_templates = TaskTemplate.default_where(q_params)
  end

  def new
    @task_template = TaskTemplate.new
  end

  def create
    @task_template = TaskTemplate.new(task_template_params)

    unless @task_template.save
      render :new, locals: { model: @task_template }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @task_template.update(task_template_params)

    if @task_template.save
      render :edit, locals: { model: @task_template }, status: :unprocessable_entity
    end
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.to_i.to_s == i }

    if params[:new_index] > params[:old_index]
      prev_one = TaskTemplate.find(sort_array[params[:new_index].to_i - 1])
      @task_template.insert_at prev_one.position
    else
      next_ones = TaskTemplate.find(sort_array[(params[:new_index] + 1)..params[:old_index]])
      next_ones.each do |next_one|
        next_one.insert_at @task.position
      end
    end

    render json: @task.as_json
  end

  def destroy
    @task_template.destroy
  end

  private
  def set_task_template
    @task_template = TaskTemplate.find(params[:id])
  end

  def task_template_params
    params.fetch(:task_template, {}).permit(
      :title,
      :tasking_type,
      :tasking_id,
      :parent_id
    )
  end

end
