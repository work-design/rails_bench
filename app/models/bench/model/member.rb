module Bench
  module Model::Member
    extend ActiveSupport::Concern

    included do
      attribute :pomodoro, :integer

      has_many :tasks, class_name: 'Bench::Task', dependent: :nullify
      has_many :task_projects, ->(o) { where.not(creator_id: o.id) }, class_name: 'Bench::TaskProject', through: :tasks, source: :tasking, source_type: 'Bench::Project'
      has_many :task_templates, class_name: 'Bench::TaskTemplate', dependent: :destroy
    end

  end
end
