module RailsBench::Tasking
  extend ActiveSupport::Concern

  included do
    has_many :tasks, as: :tasking, dependent: :destroy
  end

  def to_task
    tasks.build()
  end

end
