module RailsBench::Task
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :state, :string, default: 'todo'
    attribute :focus, :string, default: 'inbox'
    attribute :repeat_type, :string, default: 'once'
    attribute :repeat_days, :integer, array: true
    attribute :position, :integer
    attribute :estimated_time, :integer
    attribute :actual_time, :integer
    attribute :done_at, :datetime
    attribute :children_count, :integer, default: 0
    attribute :start_at, :datetime

    belongs_to :tasking, optional: true, polymorphic: true
    belongs_to :pipeline, optional: true
    belongs_to :pipeline_member, optional: true
    belongs_to :user
    belongs_to :member, optional: true
    belongs_to :organ, optional: true
    belongs_to :task_template, optional: true
    has_one :task_timer, -> { where(finish_at: nil) }
    has_many :task_timers

    delegate :members, to: :pipeline, allow_nil: true

    enum state: {
      todo: 'todo',
      doing: 'doing',
      done: 'done'
    }
    enum focus: {
      inbox: 'inbox',
      today: 'today',
      scheduled: 'scheduled'
    }

    default_scope { order(position: :asc) }
    scope :default, -> { where(state: ['todo', 'doing']) }

    after_initialize if: :new_record? do |lb|
    end
    before_save :sync_from_parent, if: -> { parent_id_changed? && parent }
    before_save :sync_task_template, if: -> { task_template_id_changed? && task_template }
    after_save :sync_estimated_time
    after_save :sync_tasking, if: -> { saved_change_to_tasking_type? || saved_change_to_tasking_id? }

    acts_as_list scope: [:user_id, :parent_id]
  end

  def same_scopes
    Task.where(user_id: self.user_id, parent_id: self.parent_id)
  end

  def sync_from_parent
    self.tasking_type = parent.tasking_type
    self.tasking_id = parent.tasking_id
  end

  def sync_task_template
    tasks.build(task_template_id: task_template)
  end

  def sync_tasking
    self.descendants.update_all(tasking_type: self.tasking_type, tasking_id: self.tasking_id)
  end

  def set_next
    if member
      next_member = pipeline.next_member self.member_id
    else
      next_member = pipeline.pipeline_members.first
    end

    if next_member
      self.member_id = next_member.member_id
    end
  end

  def set_rework
    if member
      prev_member = pipeline.prev_member self.member_id
    else
      prev_member = pipeline.pipeline_members.first
    end

    if prev_member
      self.member_id = prev_member.member_id
    end
  end

  def sync_estimated_time
    self.ancestors.each do |ancestor|
      ancestor.update estimated_time: ancestor.children.sum(:estimated_time)
    end
  end

  class_methods do

    def reset_position
      _parent_ids = self.distinct(:parent_id).pluck(:parent_id)

      _parent_ids.each do |pid|
        self.where(parent_id: pid).order(:updated_at).each_with_index do |todo_item, i|
          todo_item.update_columns(position: i + 1)
        end
      end
    end

  end

end
