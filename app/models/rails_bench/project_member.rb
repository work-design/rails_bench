module RailsBench::ProjectMember
  extend ActiveSupport::Concern

  included do
    attribute :owned, :boolean, default: false

    belongs_to :project
    belongs_to :member
    belongs_to :job_title, optional: true

    delegate :name, to: :worker, allow_nil: true, prefix: true
  end

end
