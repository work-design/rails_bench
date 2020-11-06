class Bench::Admin::TaskTemplatesController < Bench::Admin::BaseController
  before_action :set_project_taxon
  before_action :set_task_template, only: [:show, :edit, :edit_member, :update, :reorder, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:parent_id)

    @task_templates = @project_taxon.task_templates.roots.includes(:children).default_where(q_params)
  end

  def members
    q_params = {
      'member_departments.job_title_id': task_template_params[:job_title_id]
    }
    q_params.merge! default_params
    @members = Member.default_where(q_params)
  end

  def new
    @task_template = @project_taxon.task_templates.build(raw_task_template_params)
  end

  def create
    @task_template = @project_taxon.task_templates.build(task_template_params)

    unless @task_template.save
      render :new, locals: { model: @task_template }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def edit_member
    @job_titles = JobTitle.default_where(default_params)
    @members = Member.none
  end

  def update
    @task_template.assign_attributes(task_template_params)

    unless @task_template.save
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
  def set_project_taxon
    @project_taxon = ProjectTaxon.find params[:project_taxon_id]
  end

  def set_task_template
    @task_template = TaskTemplate.find(params[:id])
  end

  def prepare_form
    @job_titles = JobTitle.default_where(default_params)
  end

  def raw_task_template_params
    params.permit(
      :parent_id,
      :tasking_type,
      :tasking_id
    )
  end

  def task_template_params
    p = params.fetch(:task_template, {}).permit(
      :title,
      :tasking_type,
      :tasking_id,
      :parent_id,
      :job_title_id,
      :member_id,
      :color
    )
    p.merge! default_form_params
  end

end
