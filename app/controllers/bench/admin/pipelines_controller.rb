class Bench::Admin::PipelinesController < Bench::Admin::BaseController
  before_action :set_pipeline, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:piping_type)
    @pipelines = Pipeline.default_where(q_params).page(params[:page])
  end

  def new
    @pipeline = Pipeline.new
  end

  def create
    @pipeline = Pipeline.new(pipeline_params)

    unless @pipeline.save
      render :new, locals: { model: @pipeline }, status: :unprocessable_entity
    end
  end

  def options
    @pipeline = Pipeline.find params[:pipeline_id]
    pm = @pipeline.pipeline_members.first
    if pm
      @members = Member.default_where('member_departments.job_title_id': pm.job_title_id)
    else
      @members = Memeber.none
    end
  end

  def show
  end

  def edit
  end

  def update
    @pipeline.assign_attributes(pipeline_params)

    unless @pipeline.save
      render :edit, locals: { model: @pipeline }, status: :unprocessable_entity
    end
  end

  def destroy
    @pipeline.destroy
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
    p.merge! default_form_params
  end

end
