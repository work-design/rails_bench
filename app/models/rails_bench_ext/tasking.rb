module RailsBenchExt::Tasking
  extend ActiveSupport::Concern

  included do
    attribute :record_name, :string, default: self.name

    has_many :tasks, as: :tasking, dependent: :destroy

    has_many :task_templates, -> { roots }, foreign_key: :tasking_type, primary_key: :record_name
    has_many :job_titles, through: :task_templates
    has_many :members, through: :task_templates
  end

end
