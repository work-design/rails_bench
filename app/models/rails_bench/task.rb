module RailsBench::Task
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :position, :integer
    attribute :note, :string
    attribute :repeat_type, :string, default: 'once'
    attribute :repeat_days, :integer, array: true
    attribute :estimated_time, :integer
    attribute :actual_time, :integer
    attribute :done_at, :datetime
    attribute :children_count, :integer, default: 0
    attribute :start_at, :datetime

    belongs_to :user
    belongs_to :member, optional: true
    belongs_to :job_title, optional: true
    belongs_to :tasking, polymorphic: true, optional: true
    belongs_to :organ, optional: true
    belongs_to :task_template, optional: true
    has_one :task_timer, -> { where(finish_at: nil) }
    has_many :task_timers

    has_one_attached :proof

    enum state: {
      todo: 'todo',
      doing: 'doing',
      done: 'done',
      rework: 'rework'
    }, _default: 'todo'
    enum focus: {
      inbox: 'inbox',
      today: 'today',
      scheduled: 'scheduled'
    }, _default: 'inbox'

    default_scope { order(position: :asc) }
    scope :default, -> { where(state: ['todo', 'doing']) }

    before_validation :sync_from_parent, if: -> { (parent_id_changed? || new_record?) && parent }
    before_validation :sync_from_task_template, if: -> { task_template_id_changed? && task_template }
    before_validation :sync_from_member, if: -> { member_id_changed? && member }
    before_save :check_done, if: -> { done_at_changed? && done_at.present? }
    after_save :sync_estimated_time, if: -> { saved_change_to_estimated_time? }
    after_save :sync_tasking, if: -> { saved_change_to_tasking_type? || saved_change_to_tasking_id? }

    acts_as_list scope: [:parent_id, :tasking_type, :tasking_id]
    acts_as_notify :default, only: [:title, :start_at], methods: [:state_i18n]
  end

  def same_scopes
    self.class.where(user_id: self.user_id, parent_id: self.parent_id, organ_id: self.organ_id)
  end

  def task_templates
    TaskTemplate.where(tasking_type: tasking_type, tasking_id: tasking_id)
  end

  def sync_from_parent
    self.tasking_type = tasking_type.presence || parent.tasking_type
    self.tasking_id ||= parent.tasking_id
    self.member_id ||= parent.member_id
  end

  def sync_from_task_template
    self.title ||= task_template.title
    self.job_title_id ||= task_template.job_title_id
    self.member_id = self.member_id || task_template.member_id || parent.member_id
    task_template.children.each do |template_child|
      self.children.build(task_template_id: template_child.id)
    end
  end

  def self_and_siblings
    super.where(tasking_type: self.tasking_type, tasking_id: self.tasking_id)
  end

  def sync_from_member
    self.user_id = member.user_id
    self.organ_id = member.organ_id
  end

  def sync_tasking
    self.descendants.update_all(tasking_type: self.tasking_type, tasking_id: self.tasking_id)
  end

  def sync_estimated_time
    parent.update estimated_time: parent.children.sum(:estimated_time) if parent
  end

  def set_next
    if lower_item
      lower_item.state = 'doing' if lower_item.state == 'todo'
      lower_item.save
      lower_item.to_notification(user: lower_item.user)
    end
  end

  def check_done
    set_next
    self.state = 'done'
  end

  def notify_by_upstream
  end

  def set_rework
    if higher_item
      higher_item.state = 'rework'
      higher_item.save
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
