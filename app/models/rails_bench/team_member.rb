module RailsBench::TeamMember
  extend ActiveSupport::Concern
  included do
    belongs_to :team
    belongs_to :job_title
    belongs_to :worker, optional: true
  end
  
end
