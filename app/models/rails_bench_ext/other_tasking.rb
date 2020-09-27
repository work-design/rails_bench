module RailsBenchExt::OtherTasking
  extend ActiveSupport::Concern

  included do
    attribute :record_name, :string, default: self.name

    has_many :tasks, as: :tasking, dependent: :destroy

    has_many :task_templates, -> { roots }, as: :tasking
    has_many :job_titles, through: :task_templates
    has_many :members, through: :task_templates
  end

end
