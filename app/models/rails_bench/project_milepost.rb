module RailsBench::ProjectMilepost
  extend ActiveSupport::Concern

  included do
    attribute :recorded_on, :date
    attribute :current, :boolean, default: false
    attribute :milepost_name, :string

    belongs_to :project
    belongs_to :milepost

    after_save :set_current, if: -> { self.current? && saved_change_to_current? }
  end

  def set_current
    self.class.where.not(id: self.id).where(project_id: self.project_id).update_all(current: false)
  end

end
