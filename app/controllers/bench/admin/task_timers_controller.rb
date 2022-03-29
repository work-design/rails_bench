module Bench
  class Admin::TaskTimersController < Admin::BaseController
    before_action :set_task
    before_action :set_task_timer, only: [:show, :edit, :update, :pause, :destroy]

    def index
      q_params = {
        state: ['todo', 'doing']
      }
      q_params.merge! params.permit(:state)

      @tasks = @task.self_and_siblings.includes(:task_timer, :task_timers).default_where(q_params).page(params[:page])
      @task_timers = @task.task_timers.order(id: :desc)
    end

    def new
      @task_timer = @task.task_timers.build
    end

    def create
      @task_timer = @task.task_timers.build(task_timer_params)

      unless @task_timer.save
        render :new, locals: { model: @task_timer }, status: :unprocessable_entity
      end
    end

    def pause
      if @task_timer.pause
        render 'pause'
      else
        render :edit
      end
    end

    private
    def set_task
      @task = Task.find params[:task_id]
    end

    def set_task_timer
      @task_timer = TaskTimer.find(params[:id])
    end

    def task_timer_params
      params.fetch(:task_timer, {})
    end

    def self.local_prefixes
      [controller_path, 'bench/admin/tasks']
    end

  end
end
