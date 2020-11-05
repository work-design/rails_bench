class Bench::Me::TasksController < Bench::Admin::TasksController
  include BenchController::Me

  def index
    q_params = {
      focus: ['today', 'inbox'],
      state: ['todo', 'doing'],
    }
    q_params.merge! member_id: current_member.id
    q_params.merge! params.permit(:focus, :state, :tasking_type, :tasking_id)
    @tasks = Task.includes(:task_timers).roots.default_where(q_params).page(params[:page])
  end

end
