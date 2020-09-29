module RailsBench::ProjectMember
  extend ActiveSupport::Concern

  included do
    attribute :owned, :boolean, default: false
    attribute :source, :string

    belongs_to :project, inverse_of: :project_members
    belongs_to :member, inverse_of: :project_members, optional: true
    belongs_to :organ, optional: true
    belongs_to :job_title, optional: true
  end

end
