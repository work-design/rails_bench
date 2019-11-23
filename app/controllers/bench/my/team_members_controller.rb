class Bench::My::TeamMembersController < Bench::My::BaseController
  before_action :set_team
  before_action :set_team_member, only: [:show, :edit, :update, :edit_worker, :update_worker, :workers, :destroy]
  skip_before_action :verify_authenticity_token, only: [:search]

  def index
    @team_members = @team.team_members.page(params[:page])
  end

  def search
    @team_members = @team.team_members.where.not(worker_id: nil).where(duty_id: params[:duty_id])

    results = @team_members.map { |x| { value: x.worker_id, text: x.worker_name, name: x.worker_name } }

    respond_to do |format|
      format.js
      format.json { render json: { values: results } }
    end
  end

  def new
    @team_member = @team.team_members.build
  end

  def create
    @team_member = @team.team_members.build(team_member_params)

    respond_to do |format|
      if @team_member.save
        format.html { redirect_to my_team_members_url(@team), notice: 'Project member was successfully created.' }
        format.json { render :show, status: :created, location: @team_member }
      else
        format.html { render :new }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to my_team_members_url(@team), notice: 'Project member was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_member }
      else
        format.html { render :edit }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_worker

  end

  def update_worker
    respond_to do |format|
      if @team_member.update(worker_id: team_member_params[:worker_id])
        format.html { redirect_to my_team_members_url(@team), notice: 'Employee was successfully updated.' }
        format.js
      else
        format.html { redirect_to my_team_members_url(@team) }
        format.js
      end
    end
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
      @workers = user.workers.where(duty_id: @team_member.duty_id)
    else
      @workers = Worker.none
    end

    render json: { results: @workers.as_json(only: [:id, :user_name]) }
  end

  def destroy
    @team_member.destroy
  end

  private
  def set_team
    @team = Team.find params[:team_id]
  end

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.fetch(:team_member, {}).permit(
      :duty_id,
      :worker_id
    )
  end

end
