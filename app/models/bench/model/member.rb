module Bench
  module Model::Member
    extend ActiveSupport::Concern

    included do
      attribute :pomodoro, :integer

      has_many :tasks, dependent: :nullify
      has_many :task_projects, ->(o) { where.not(creator_id: o.id) }, through: :tasks, source: :tasking, source_type: 'Project'
      has_many :task_templates, dependent: :destroy
    end

  end
end
