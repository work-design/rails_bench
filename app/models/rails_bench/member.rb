module RailsBench::Member
  extend ActiveSupport::Concern

  included do
    attribute :pomodoro, :integer

    belongs_to :provider, optional: true

    has_many :tasks, dependent: :nullify
    has_many :project_members, dependent: :nullify
    has_many :projects, through: :project_members
    has_many :pipeline_members, dependent: :nullify
    has_many :pipelines, through: :pipeline_members
    has_many :task_masters, dependent: :destroy
  end

end
