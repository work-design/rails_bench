class Bench::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :github, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:github]

  def index
    @projects = Project.all.page(params[:page])
  end

  def show
  end

  def github
    @project.project_webhooks.create origin_data: params.permit!
    head :no_content
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(
      :name,
      :description
    )
  end

end
