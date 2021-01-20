module RailsBench::ProjectMilepost
  extend ActiveSupport::Concern

  included do
    attribute :recorded_on, :date
    attribute :current, :boolean, default: false
    attribute :milepost_name, :string

    belongs_to :project
    belongs_to :milepost

    before_validation :sync_name, if: -> { milepost_id_changed? }
    after_save :set_current, if: -> { self.current? && saved_change_to_current? }
  end

  def set_current
    self.class.where.not(id: self.id).where(project_id: self.project_id).update_all(current: false)
  end

  def sync_name
    self.milepost_name = milepost&.name
  end

end
