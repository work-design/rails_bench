class Bench::Admin::PipelineMembersController < Bench::Admin::BaseController
  before_action :set_pipeline
  before_action :set_pipeline_member, only: [:show, :edit, :update, :reorder, :destroy]
  #before_action :set_piping, only: [:new]



  def new
    @pipeline_member = @pipeline.pipeline_members.build

    # if @piping.is_a?(Project)
    #   @job_titles = @piping.duties
    # else
    #   @job_titles = JobTitle.default_where(default_params)
    # end
  end

  def create
    @pipeline_member = @pipeline.pipeline_members.build(pipeline_member_params)

    unless @pipeline_member.save
      render :new, locals: { model: @pipeline_member }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    q_params = {
      super_job_title_id: nil,
      allow: { super_job_title_id: nil }
    }
    q_params.merge! default_params
    @job_titles = JobTitle.default_where(q_params)
    if @pipeline_member.job_title
      @members = @pipeline_member.job_title.members
    else
      @members = Member.none
    end
  end

  def update
    @pipeline_member.assign_attributes(pipeline_member_params)

    unless @pipeline_member.save
      render :edit, locals: { model: @pipeline_member }, status: :unprocessable_entity
    end
  end

  def reorder
    sort_array = params[:sort_array].select { |i| i.integer? }

    if params[:new_index] > params[:old_index]
      prev_one = @pipeline_member.same_scope.find(sort_array[params[:new_index].to_i - 1])
      @pipeline_member.insert_at prev_one.position
    else
      next_ones = @pipeline_member.same_scope.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
      next_ones.each do |next_one|
        next_one.insert_at @pipeline_member.position
      end
    end
  end

  def destroy
    @pipeline_member.destroy
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
      :color,
      :master
    )
  end
end
