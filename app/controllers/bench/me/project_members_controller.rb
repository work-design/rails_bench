class Bench::Me::ProjectMembersController < Bench::Me::BaseController
  before_action :set_project
  before_action :set_project_member, only: [:show, :edit, :update, :edit_worker, :update_worker, :workers, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @project_members = @project.project_members.page(params[:page])
  end

  def search
    @project_members = @project.project_members.where.not(worker_id: nil).where(duty_id: params[:duty_id])

    results = @project_members.map { |x| { value: x.worker_id, text: x.worker_name, name: x.worker_name } }

    respond_to do |format|
      format.js
      format.json { render json: { values: results } }
    end
  end

  def new
    @project_member = @project.project_members.build
  end

  def create
    @project_member = @project.project_members.build(project_member_params)

    unless @project_member.save
      render :new, locals: { model: @project_member }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @project_member.assign_attributes(project_member_params)

    unless @project_member.save
      render :edit, locals: { model: @project_member }, status: :unprocessable_entity
    end
  end

  def edit_worker

  end

  def workers
    if params[:q].include?('@')
      user = User.find_by(email: params[:q])
    elsif params[:q] =~ /\d+/
      user = User.find_by(mobile: params[:q])
    else
      user = User.find_by(name: params[:q])
    end

    if user
      @workers = user.workers.where(duty_id: @project_member.duty_id)
    else
      @workers = Worker.none
    end

    render json: { results: @workers.as_json(only: [:id, :user_name]) }
  end

  def destroy
    @project_member.destroy
  end

  private
  def set_project
    @project = Project.find params[:project_id]
  end

  def set_project_member
    @project_member = ProjectMember.find(params[:id])
  end

  def prepare_form
    @job_titles = JobTitle.default_where(default_params)
  end

  def project_member_params
    params.fetch(:project_member, {}).permit(
      :job_title_id,
      :member_id
    )
  end

end
