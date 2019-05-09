module RailsBench::PipelineMember
  extend ActiveSupport::Concern
  included do
    attribute :position, :integer, default: 1

    acts_as_list scope: [:pipeline_id]

    belongs_to :pipeline
    belongs_to :job_title, optional: true
    belongs_to :member, optional: true
  
    validates :member_id, uniqueness: { scope: [:pipeline_id, :job_title_id] }
  end
  



end
