module RailsBench::ProjectMember
  extend ActiveSupport::Concern
  included do
    belongs_to :project
    belongs_to :job_title
    belongs_to :member, optional: true
  
    delegate :name, to: :worker, allow_nil: true, prefix: true
  end
  
end
