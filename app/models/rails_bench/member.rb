module RailsBench::Member
  extend ActiveSupport::Concern
  included do
    attribute :pomodoro, :integer
    
    belongs_to :provider, optional: true

    has_many :task_workers
    has_many :tasks, through: :task_workers
    has_many :project_members, dependent: :nullify
    has_many :projects, through: :project_members
    has_many :pipelines, dependent: :nullify
  end
  
end



