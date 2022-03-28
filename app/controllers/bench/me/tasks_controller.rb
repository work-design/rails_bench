module Bench
  class Me::TasksController < Admin::TasksController
    before_action :set_task, only: [:project, :show, :edit, :update, :edit_focus, :update_focus, :destroy]
    include Controller::Me

    def index
      q_params = {
        focus: ['today', 'inbox'],
        state: ['todo', 'doing'],
        member_id: current_member.id
      }
      q_params.merge! params.permit(:focus, :state, :project_id)

      @tasks = Task.includes(:project, :task_timers, :children).roots.default_where(q_params).page(params[:page])
    end

    def create
      @task = current_member.tasks.build task_params

      if @task.save
        render 'create'
      else
        render :new, locals: { model: @task }, status: :unprocessable_entity
      end
    end

    def show
      q_params = {
        member_id: current_member.id
      }
      q_params.merge! params.permit(:state, :focus)

      @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
    end

    def project
      q_params = {
        member_id: current_member.id
      }
      q_params.merge! params.permit(:state)

      @tasks = @task.self_and_siblings.default_where(q_params).page(params[:page])
    end

    private
    def set_task
      @task = Task.find params[:id]
    end

  end
end
