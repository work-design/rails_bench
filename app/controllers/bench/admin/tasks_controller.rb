module Bench
  class Admin::TasksController < Admin::BaseController
    before_action :set_task, only: [
      :show, :edit, :stock, :fund, :estimated, :update, :edit_focus, :edit_assign, :reorder,
      :edit_done, :update_done, :rework, :destroy
    ]
    before_action :prepare_form, only: [:show]

    def index
      q_params = {
        focus: ['today', 'inbox'],
        state: ['todo', 'doing'],
      }
      q_params.merge! params.permit(:focus, :state, :tasking_type, :tasking_id)

      @tasks = Task.includes(:task_timers).roots.default_where(q_params).page(params[:page])
    end

    def project
      q_params = {}
      q_params.merge! params.permit(:state)

      @project = Project.find params[:project_id]
      @tasks = @project.tasks.roots.default_where(q_params)
    end

    def new
      @task = Task.new raw_task_params
    end

    def create
      @task = current_member.tasks.build task_params

      if @task.save
        render 'create'
      else
        render :new, locals: { model: @task }, status: :unprocessable_entity
      end
    end

    def new_template
      @task = Task.new raw_task_params
    end

    def show
      q_params = {}
      q_params.merge! params.permit(:state, :focus)

      @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
    end

    def reorder
      @task = Task.find params[:id]
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

    def stock
    end

    def fund
    end

    def edit_assign
      q_params = {
        'member_departments.job_title_id': @task.job_title_id
      }
      q_params.merge! default_params
      @members = Member.default_where(q_params)
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

    private
    def set_task
      @task = Task.find(params[:id])
    end

    def prepare_form
      @task_templates = TaskTemplate.where(tasking_type: @task)
    end

    def raw_task_params
      params.permit(
        :parent_id,
        :project_id
      )
    end

    def task_params
      p = params.fetch(:task, {}).permit(
        :project_id,
        :title,
        :focus,
        :content,
        :parent_id,
        :member_id,
        :task_template_id,
        :estimated_time,
        :note,
        :done_at,
        :cost_fund,
        :cost_stock,
        :proof
      )
      p.merge! default_form_params
    end

  end
end
