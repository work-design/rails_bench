class Bench::My::TeamsController < Bench::My::BaseController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.includes(:members).page(params[:page])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to my_teams_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to my_teams_url
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to my_teams_url
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.fetch(:team, {}).permit(
      :name,
      :description
    )
  end

end
