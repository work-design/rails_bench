class Bench::My::TaskTemplatesController < Bench::My::BaseController
  before_action :set_tasking, only: [:index, :new, :create]
  before_action :set_task_template, only: [:show, :edit, :update, :reorder, :destroy]

  def index
    @task_templates = @tasking.task_templates.ordered
  end

  def new
    @task_template = @tasking.task_templates.build
  end

  def create
    @task_template = TaskTemplate.new(task_template_params)

    respond_to do |format|
      if @task_template.save
        format.js
        format.html { redirect_to @task_template, notice: 'Task template was successfully created.' }
        format.json { render :show, status: :created, location: @task_template }
      else
        format.js
        format.html { render :new }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task_template.update(task_template_params)
        format.js
        format.html { redirect_to @task_template, notice: 'Task template was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_template }
      else
        format.js
        format.html { render :edit }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
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
    respond_to do |format|
      format.html { redirect_to task_templates_url, notice: 'Task template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_tasking
    if ['FacilitateProvider'].include?(params[:tasking_type]) && params[:tasking_id]
      @tasking = params[:tasking_type].constantize.find params[:tasking_id]
    end
  end

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
