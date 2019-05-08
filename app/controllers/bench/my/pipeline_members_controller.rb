class Bench::My::PipelineMembersController < Bench::My::BaseController
  before_action :set_pipeline
  before_action :set_pipeline_member, only: [:show, :edit, :update, :destroy]
  before_action :set_piping, only: [:new]

  def index
    @pipeline_members = PipelineMember.all
  end

  def new
    @pipeline_member = @pipeline.pipeline_members.build
    if @piping.is_a?(Project)
      @duties = @piping.duties
    else
      @duties = Duty.all
    end
  end

  def create
    @pipeline_member = @pipeline.pipeline_members.build(pipeline_member_params)

    respond_to do |format|
      if @pipeline_member.save
        format.html { redirect_to my_pipelines_url(piping_type: @pipeline.piping_type, piping_id: @pipeline.piping_id), notice: 'Pipeline member was successfully created.' }
        format.json { render :show, status: :created, location: @pipeline_member }
      else
        format.html { render :new }
        format.json { render json: @pipeline_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @pipeline_member.update(pipeline_member_params)
        format.html { redirect_to @pipeline_member, notice: 'Pipeline member was successfully updated.' }
        format.json { render :show, status: :ok, location: @pipeline_member }
      else
        format.html { render :edit }
        format.json { render json: @pipeline_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pipeline_member.destroy
    respond_to do |format|
      format.html { redirect_to my_pipeline_members_url, notice: 'Pipeline member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_pipeline
    @pipeline = Pipeline.find params[:pipeline_id]
  end

  def set_piping
    @piping = params[:piping_type].constantize.find params[:piping_id]
  end

  def set_pipeline_member
    @pipeline_member = PipelineMember.find(params[:id])
  end

  def pipeline_member_params
    params.fetch(:pipeline_member, {}).permit(
      :duty_id,
      :position,
      :worker_id
    )
  end
end
