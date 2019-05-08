module RailsBench::PipelineMember
  extend ActiveSupport::Concern
  included do
    attribute :project_id, :integer
    attribute :position, :integer, default: 1

    acts_as_list scope: [:pipeline_id]

    belongs_to :pipeline
    belongs_to :duty
    belongs_to :worker
  
    validates :worker_id, uniqueness: { scope: [:pipeline_id, :duty_id] }
  end
  



end
