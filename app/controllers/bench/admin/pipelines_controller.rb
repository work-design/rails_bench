class Bench::Admin::PipelinesController < Bench::Admin::BaseController
  before_action :set_pipeline, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
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
