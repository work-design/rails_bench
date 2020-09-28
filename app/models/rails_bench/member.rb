module RailsBench::Member
  extend ActiveSupport::Concern

  included do
    attribute :pomodoro, :integer

    has_many :tasks, dependent: :nullify
    has_many :projects, foreign_key: :creator_id
    has_many :task_templates, dependent: :destroy
  end

end
