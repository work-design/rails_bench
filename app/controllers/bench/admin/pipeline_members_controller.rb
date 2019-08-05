class Bench::Admin::PipelineMembersController < Bench::Admin::BaseController
  before_action :set_pipeline
  before_action :set_pipeline_member, only: [:show, :edit, :update, :reorder, :destroy]
  #before_action :set_piping, only: [:new]

  def index
    @pipeline_members = PipelineMember.all
  end

  def new
    @pipeline_member = @pipeline.pipeline_members.build
    @job_titles = JobTitle.default_where(default_params)
    @members = Member.none
    # if @piping.is_a?(Project)
    #   @job_titles = @piping.duties
    # else
    #   @job_titles = JobTitle.default_where(default_params)
    # end
  end

  def create
    @pipeline_member = @pipeline.pipeline_members.build(pipeline_member_params)

    respond_to do |format|
      if @pipeline_member.save
        format.html { redirect_to admin_pipelines_url(piping_type: @pipeline.piping_type, piping_id: @pipeline.piping_id) }
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
    q_params = {
      super_job_title_id: nil
    }
    q_params.merge! default_params
    @job_titles = JobTitle.default_where(q_params, super_job_title_id: { allow: nil })
    if @pipeline_member.job_title
      @members = @pipeline_member.job_title.members
    else
      @members = Member.none
    end
  end

  def update
    @pipeline_member.assign_attributes(pipeline_member_params)
    respond_to do |format|
      if @pipeline_member.save
        format.html { redirect_to @pipeline_member }
        format.js
        format.json { render :show, status: :ok, location: @pipeline_member }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @pipeline_member.errors, status: :unprocessable_entity }
      end
    end
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.integer? }
  
    if params[:new_index] > params[:old_index]
      prev_one = @pipeline_member.same_scope.find(sort_array[params[:new_index].to_i - 1])
      @pipeline_member.insert_at prev_one.position
    else
      next_ones = @pipeline_member.same_scope.find(sort_array[(params[:new_index] + 1)..params[:old_index]])
      next_ones.each do |next_one|
        next_one.insert_at @pipeline_member.position
      end
    end
  end

  def destroy
    @pipeline_member.destroy
    respond_to do |format|
      format.js
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
    @pipeline_member = @pipeline.pipeline_members.find(params[:id])
  end

  def pipeline_member_params
    params.fetch(:pipeline_member, {}).permit(
      :name,
      :job_title_id,
      :member_id,
      :color
    )
  end
end
