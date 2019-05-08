module RailsBench::ProjectMember
  extend ActiveSupport::Concern
  included do
    belongs_to :project
    belongs_to :duty
    belongs_to :worker, optional: true
  
    delegate :name, to: :worker, allow_nil: true, prefix: true
  end
  
end
