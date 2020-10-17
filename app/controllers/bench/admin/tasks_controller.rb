class Bench::Admin::TasksController < Bench::Admin::BaseController

  def project
    q_params = {}
    q_params.merge! params.permit(:state)

    @project = Project.find params[:project_id]
    @tasks = @project.tasks.roots.default_where(q_params)
  end

end
