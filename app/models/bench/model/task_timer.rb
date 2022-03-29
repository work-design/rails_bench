module Bench
  module Model::TaskTimer
    extend ActiveSupport::Concern

    included do
      attribute :duration, :integer
      attribute :finish_at, :datetime

      belongs_to :task
    end

    def pause
      self.finish_at = Time.current
      self.duration = (self.finish_at - created_at).to_i
      self.save
    end

    def duration_format
    end

  end
end
