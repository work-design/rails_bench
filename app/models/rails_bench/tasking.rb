module RailsBench::Tasking
  extend ActiveSupport::Concern

  included do
    attribute :record_name, :string, default: self.name

    has_many :tasks, as: :tasking, dependent: :destroy

    has_many :task_masters, foreign_key: :tasking_type, primary_key: :record_name
    has_many :members, through: :task_masters
  end

  def to_task
    tasks.build()
  end

end
