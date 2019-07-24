class Bench::Admin::PipelinesController < Bench::Admin::BaseController
  before_action :set_pipeline, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! organ_ancestors_params
    @pipelines = Pipeline.default_where(q_params).page(params[:page])
  end

  def new
    @pipeline = Pipeline.new
  end

  def create
    @pipeline = Pipeline.new(pipeline_params)

    respond_to do |format|
      if @pipeline.save
        format.html.phone
        format.html { redirect_to admin_pipelines_url }
        format.js { redirect_back fallback_location: admin_pipelines_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_pipelines_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def members
    # if @pipeline.piping_type == 'FacilitateProvider'
    #   @members = @pipeline.piping.provider.members.where(duty_id: params[:duty_id])
    # elsif @pipeline.piping_type == 'Project'
    #   member_ids = @pipeline.piping.project_members.where.not(member_id: nil).where(duty_id: params[:duty_id]).pluck(:member_id)
    # end
    q_params = {
      'member_departments.job_title_id': params[:job_title_id]
    }
    q_params.merge! default_params
    @members = Member.default_where(q_params)
    @pipeline_member = PipelineMember.new
  
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    @pipeline.assign_attributes(pipeline_params)

    respond_to do |format|
      if @pipeline.save
        format.html.phone
        format.html { redirect_to admin_pipelines_url }
        format.js { redirect_back fallback_location: admin_pipelines_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_pipelines_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @pipeline.destroy
    redirect_to admin_pipelines_url
  end

  private
  def set_pipeline
    @pipeline = Pipeline.find(params[:id])
  end

  def pipeline_params
    p = params.fetch(:pipeline, {}).permit(
      :name,
      :description,
      :piping_type
    )
    p.merge! default_params
  end

end
