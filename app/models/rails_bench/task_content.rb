module RailsBench::TaskContent
  extend ActiveSupport::Concern
  included do
    belongs_to :task
  end

end



