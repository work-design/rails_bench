module RailsBench::ProjectWebhook
  extend ActiveSupport::Concern
  included do
    belongs_to :project
  end

end
