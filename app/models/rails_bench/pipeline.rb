module RailsBench::Pipeline
  extend ActiveSupport::Concern
  included do
    belongs_to :piping, polymorphic: true
    has_many :pipeline_members, dependent: :destroy
    has_many :workers, through: :pipeline_members
  end
  
  def next_member(worker_id)
    member = pipeline_members.find_by(worker_id: worker_id)
    member.lower_item if member
  end

  def prev_member(worker_id)
    member = pipeline_members.find_by(worker_id: worker_id)
    member.higher_item if member
  end

end


# pipeline -> pipeline_member -> pipeline_worker
#
