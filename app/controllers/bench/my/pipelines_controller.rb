class Bench::My::PipelinesController < Bench::My::BaseController
  before_action :set_piping, only: [:index, :new]
  before_action :set_pipeline, only: [:show, :workers, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:workers]

  def index
    @pipelines = @piping.pipelines.page(params[:page])
  end

  def new
    @pipeline = @piping.pipelines.build
  end

  def create
    @pipeline = Pipeline.new(pipeline_params)

    respond_to do |format|
      if @pipeline.save
        format.html { redirect_to my_pipelines_url(piping_type: @pipeline.piping_type, piping_id: @pipeline.piping_id) }
        format.json { render :show, status: :created, location: @pipeline }
      else
        format.html { render :new }
        format.json { render json: @pipeline.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def workers
    if @pipeline.piping_type == 'FacilitateProvider'
      @workers = @pipeline.piping.provider.workers.where(duty_id: params[:duty_id])
    elsif @pipeline.piping_type == 'Project'
      worker_ids = @pipeline.piping.project_members.where.not(worker_id: nil).where(duty_id: params[:duty_id]).pluck(:worker_id)
      @workers = Worker.where(id: worker_ids)
    end

    if @workers
      @results = @workers.map { |x| { value: x.id, text: x.name, name: x.name } }
    end

    @pipeline_member = PipelineMember.new

    respond_to do |format|
      format.js
      format.json { render json: { values: @results } }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @pipeline.update(pipeline_params)
        format.html { redirect_to my_pipelines_url(piping_type: @pipeline.piping_type, piping_id: @pipeline.piping_id) }
        format.json { render :show, status: :ok, location: @pipeline }
      else
        format.html { render :edit }
        format.json { render json: @pipeline.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pipeline.destroy
    respond_to do |format|
      format.html { redirect_to my_pipelines_url(piping_type: @pipeline.piping_type, piping_id: @pipeline.piping_id) }
      format.json { head :no_content }
    end
  end

  private
  def set_piping
    if ['Project', 'FacilitateProvider'].include?(params[:piping_type]) && params[:piping_id]
      @piping = params[:piping_type].constantize.find params[:piping_id]
    end
  end

  def set_pipeline
    @pipeline = Pipeline.find(params[:id])
  end

  def pipeline_params
    params.fetch(:pipeline, {}).permit(
      :name,
      :description,
      :piping_type,
      :piping_id
    )
  end

end
