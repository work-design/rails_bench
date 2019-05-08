module RailsBench::TaskTimer
  extend ActiveSupport::Concern
  included do
    belongs_to :task
  end

  def pause
    self.finish_at = Time.now
    self.duration = (self.finish_at - created_at).to_i
    self.save
  end

  def duration_format

  end

  def finish_at
    super || Time.now
  end

end



