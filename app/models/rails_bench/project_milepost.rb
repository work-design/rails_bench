module RailsBench::ProjectMilepost
  extend ActiveSupport::Concern

  included do
    attribute :recorded_on, :date

    belongs_to :project
    belongs_to :milepost
  end

end
