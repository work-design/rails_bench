module Bench
  class Me::TaskTemplatesController < Admin::TaskTemplatesController
    include Controller::Me
    before_action :set_task_template, only: [:show, :members, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:tasking_type, :tasking_id)

      @task_templates = TaskTemplate.where(q_params).page(params[:page])
    end

    def new
      @task_template = TaskTemplate.new params.permit(:tasking_type, :tasking_id)
    end

    def create
      @task_template = TaskTemplate.new(task_template_params)

      unless @task_template.save
        render :new, locals: { model: @task_template }, status: :unprocessable_entity
      end
    end

    def members
      if @task_template.piping_type == 'FacilitateProvider'
        @workers = @task_template.piping.provider.workers.where(duty_id: params[:duty_id])
      elsif @task_template.piping_type == 'Project'
        worker_ids = @task_template.piping.project_members.where.not(worker_id: nil).where(duty_id: params[:duty_id]).pluck(:worker_id)
        @workers = Worker.where(id: worker_ids)
      end

      if @workers
        @results = @workers.map { |x| { value: x.id, text: x.name, name: x.name } }
      end

      @task_template_member = task_templateMember.new
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
        :job_title_id,
        :member_id
      )
    end

  end
end
