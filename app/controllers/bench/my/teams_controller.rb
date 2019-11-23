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

    unless @team.save
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @team.assign_attributes(team_params)
    
    unless @team.save
      render :edit
    end
  end

  def destroy
    @team.destroy
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
