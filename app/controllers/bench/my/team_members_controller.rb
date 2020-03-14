class Bench::My::TeamMembersController < Bench::My::BaseController
  before_action :set_team
  before_action :set_team_member, only: [:show, :edit, :update, :edit_member, :update_member, :members, :destroy]
  skip_before_action :verify_authenticity_token, only: [:search]

  def index
    @team_members = @team.team_members.page(params[:page])
  end

  def search
    @team_members = @team.team_members.where.not(member_id: nil).where(duty_id: params[:duty_id])

    results = @team_members.map { |x| { value: x.member_id, text: x.member_name, name: x.member_name } }

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

    if @team_member.save
      render 'create', locals: { return_to: my_team_members_url(@team) }
    else
      render :new, locals: { model: @user }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @team_member.assign_attributes team_member_params

    if @team_member.save
      render 'update', locals: { return_to: my_team_members_url(@team) }
    else
      render :new, locals: { model: @user }, status: :unprocessable_entity
    end
  end

  def edit_member

  end

  def members
    if params[:q].include?('@')
      user = User.find_by(email: params[:q])
    elsif params[:q] =~ /\d+/
      user = User.find_by(mobile: params[:q])
    else
      user = User.find_by(name: params[:q])
    end

    if user
      @members = user.members.where(duty_id: @team_member.job_title_id)
    else
      @members = Member.none
    end

    render json: { results: @members.as_json(only: [:id, :name]) }
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
      :job_title_id,
      :member_id
    )
  end

end
