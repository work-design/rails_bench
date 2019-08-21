module RailsBench::PipelineMember
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    attribute :position, :integer
    attribute :color, :string

    acts_as_list scope: [:pipeline_id]

    belongs_to :pipeline
    belongs_to :job_title, optional: true
    belongs_to :member, optional: true
  
    validates :member_id, uniqueness: { scope: [:pipeline_id, :job_title_id] }
  end

  def same_scope
    self.class.where(pipeline_id: self.pipeline_id)
  end
  
  def next_member
    self.lower_item
  end

  def prev_member
    self.higher_item
  end


end
