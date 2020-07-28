module RailsBench::Log
  extend ActiveSupport::Concern

  included do
    attribute :task_id, :integer
    attribute :started_at, :datetime
    attribute :stopped_at, :datetime
  end

end
