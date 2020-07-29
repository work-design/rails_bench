module RailsBench::Tasking
  extend ActiveSupport::Concern

  included do
    attribute :record_name, :string, default: self.name

    has_many :tasks, as: :tasking, dependent: :destroy

    has_many :task_masters, foreign_key: :tasking_type, primary_key: :record_name
    has_many :members, through: :task_masters
    has_many :task_templates, -> { roots }, foreign_key: :tasking_type, primary_key: :record_name
  end

  def to_task(member_id, task_template_id)
    member = Member.find member_id
    member.tasks.build(task_template_id: task_template_id, tasking_type: self.class_name, tasking_id: self.id)
  end

  def to_task!(member_id, task_template_id)
    task = to_task(member_id, task_template_id)
    task.save
    task
  end

end