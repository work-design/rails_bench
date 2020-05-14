module RailsBench::Task
  extend ActiveSupport::Concern

  included do
    attribute :title, :string
    attribute :state, :string, default: 'todo'
    attribute :focus, :string, default: 'inbox'
    attribute :repeat_type, :string
    attribute :repeat_days, :integer, array: true
    attribute :position, :integer
    attribute :estimated_time, :integer
    attribute :actual_time, :integer
    attribute :done_at, :datetime
    attribute :children_count, :integer, default: 0
    attribute :detail_id, :integer
    attribute :start_at, :datetime

    # Before
    belongs_to :project, optional: true

    # Used
    belongs_to :pipeline, optional: true
    belongs_to :user
    belongs_to :member, optional: true
    belongs_to :organ, optional: true
    has_one :task_timer, -> { where(finish_at: nil) }
    has_many :task_timers

    delegate :workers, to: :pipeline, allow_nil: true

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
    after_save :sync_estimated_time

    acts_as_list scope: [:user_id, :parent_id]
  end

  def same_scopes
    Task.where(user_id: self.user_id, parent_id: self.parent_id)
  end

  def save_with_parent
    self.project_id = parent.project_id if parent
    save
  end

  def update_project_id(project_id)
    self.project_id = project_id
    self.class.transaction do
      self.descendants.update_all(project_id: self.project_id)
      self.save!
    end
  end

  def set_current(worker_id)
    self.worker_id = worker_id
  end

  def set_next
    if worker
      next_member = pipeline.next_member self.worker_id
    else
      next_member = pipeline.pipeline_members.first
    end

    if next_member
      self.worker_id = next_member.worker_id
      self.save
    end
  end

  def set_rework
    if worker
      prev_member = pipeline.prev_member self.worker_id
    else
      prev_member = pipeline.pipeline_members.first
    end

    if prev_member
      self.worker_id = prev_member.worker_id
      self.save
    end
  end

  def sync_estimated_time
    self.ancestors.each do |ancestor|
      ancestor.update estimated_time: ancestor.children.sum(:estimated_time)
    end
  end

  def self.reset_position
    _parent_ids = self.distinct(:parent_id).pluck(:parent_id)

    _parent_ids.each do |pid|
      self.where(parent_id: pid).order(:updated_at).each_with_index do |todo_item, i|
        todo_item.update_columns(position: i + 1)
      end
    end
  end

end

# task => pipeline => pipeline_members => workers



