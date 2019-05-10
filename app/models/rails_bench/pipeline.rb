module RailsBench::Pipeline
  extend ActiveSupport::Concern
  included do
    belongs_to :piping, polymorphic: true, optional: true
    has_many :pipeline_members, ->{ order(position: :asc) }, dependent: :destroy
    has_many :members, through: :pipeline_members
  end
  
  def next_member(member_id)
    pm = pipeline_members.find_by(member_id: member_id)
    pm.lower_item if member
  end

  def prev_member(member_id)
    pm = pipeline_members.find_by(member_id: member_id)
    pm.higher_item if member
  end

end


# pipeline -> pipeline_member -> pipeline_worker
#
