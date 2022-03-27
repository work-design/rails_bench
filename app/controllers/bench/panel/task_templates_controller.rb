module Bench
  class Panel::TaskTemplatesController < Panel::BaseController
    before_action :set_taxon
    before_action :set_task_template, only: [:show, :edit, :edit_member, :update, :reorder, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:parent_id)

      @task_templates = @taxon.task_templates.roots.includes(:children).order(position: :asc).default_where(q_params)
    end

    def departments
      # todo remove roots
      @departments = Org::Department.roots.where(organ_id: task_template_params[:organ_id])
    end

    def job_titles
      # todo remove xx
      @job_titles = Org::JobTitle.default_where(department_root_id: task_template_params[:department_id])
    end

    def members
      q_params = {
        'member_departments.job_title_id': task_template_params[:job_title_id]
      }
      @members = Org::Member.default_where(q_params)
    end

    def new
      @task_template = @taxon.task_templates.build(raw_task_template_params)
    end

    def create
      @task_template = @taxon.task_templates.build(task_template_params)

      unless @task_template.save
        render :new, locals: { model: @task_template }, status: :unprocessable_entity
      end
    end

    def edit_member
      @task_template.organ = current_organ

      @organs = Organ.all
      @departments = Department.default_where(default_params)
      @job_titles = JobTitle.none
      @members = Member.none
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

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_task_template
      @task_template = TaskTemplate.find(params[:id])
    end

    def raw_task_template_params
      params.permit(
        :parent_id
      )
    end

    def task_template_params
      params.fetch(:task_template, {}).permit(
        :title,
        :parent_id,
        :organ_id,
        :department_id,
        :job_title_id,
        :member_id,
        :color
      )
    end

  end
end
